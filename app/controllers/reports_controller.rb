class ReportsController < ApplicationController

  def index
    @fbih = District.where(:entity_id => 9000)
    @rs = District.where(:entity_id => 9100)
    @entities = Entity.all
  end

  def make_sum_report
    puts params[:sumreport][0].inspect
    puts params[:periodvalue].inspect
    if params[:sumreport][0].downcase == 'm' && params[:periodvalue].to_i > 12
      redirect_to(reports_path, :notice => t(:wrong_period_value)) 
      return false
    end
  end


  def make_report
    if (params[:entity]["entity"].blank? || params[:week].blank? || params[:week].to_i < 1 || params[:week].to_i > 52 || !params[:report]) 
        redirect_to(reports_path, :notice => t(:select_entity_and_week)) 
        return false
    else 
      @week = params[:week]
      @r = params[:report].to_i
      @year = params[:year].to_i
      @entity = params[:entity]["entity"].to_s
      @district_id = params[:district][@entity]? params[:district][@entity].to_i : 1300
      if (@district_id == 0) 
        redirect_to(reports_path, :notice => t(:select_entity_and_week))
        return false
      end

      @weeks = []
      ((@week.to_i - 5)..@week.to_i).each do |week|
        year = @year
        if week <= 0 
          year -=  1
          week = 52 + week
        end
        wd = week_dates(week, year)
        @weeks << {"week"=>week, "year"=>year, "start" => wd[:start], "end" => wd[:end] }
      end
      @district = District.find(@district_id)
      prepare_reports_tables

      @report = send("report#{@r}")
    end
  end

  def week_dates( week_num, year )
    week_start = Date.commercial( year, week_num, 1 )
    week_end = Date.commercial( year, week_num, 7 )
    {:start => week_start.strftime( "%Y-%m-%d" ), :end => week_end.strftime( "%Y-%m-%d" )}
  end

  def report1

    Report.table_name = 'report111'
    i = 0;
    @weeks.each do |week|
      i += 1
      cases = Case.find_by_sql("
        SELECT icd_id, count(id) as num from cases where 
        weekofyear(date_of_dg) = #{week['week']} and year(date_of_dg) = #{week['year']}  and district_id = #{@district_id}
        group by icd_id, year(date_of_dg), weekofyear(date_of_dg), date_of_dg
      ")
      cases.each do |c|
        report = Report.where(:item_id => c.icd_id).first
        report["col#{i}"] = c.num.to_i
        report.save
      end
    end
    @year = @year.to_i
    median = Case.find_by_sql("
      SELECT icd_id, count(*) as sum, weekofyear(date_of_dg) as week , year(date_of_dg) as godina
      from icds 
      left join cases on icds.id = cases.icd_id
      where district_id = #{@district_id} and weekofyear(date_of_dg) <= #{@week} and weekofyear(date_of_dg) > 1 and year(date_of_dg) = #{@year}
      or  district_id = #{@district_id} and weekofyear(date_of_dg) <= #{@week} and weekofyear(date_of_dg) > 1 and year(date_of_dg) = #{@year-1}
      or  district_id = #{@district_id} and weekofyear(date_of_dg) <= #{@week} and weekofyear(date_of_dg) > 1 and year(date_of_dg) = #{@year-2}
      group by icds.id, year(date_of_dg), weekofyear(date_of_dg), date_of_dg;
    ")
    tmp = {}

    median.each do |m|
      if !tmp[m.icd_id]
        tmp[m.icd_id] = {}
      end
      if !tmp[m.icd_id][m.godina]
        tmp[m.icd_id][m.godina] = []
      end
      tmp[m.icd_id][m.godina] << m.sum if m.sum
    end

    tmp.each do |icd_id, years|
        i = 9
        years.each do |year,med|
          i -= @year - year
          tmp[icd_id][year] = year_median = Report.median(med)
          report = Report.where(:item_id => icd_id).first
          report["col#{i}"] = year_median
          report["col#{i+3}"] = ((year_median / @district.population) * 100000).round(5) if year_median
          report.save
        end
    end

    Report.all
  end

  def report2
    Report.table_name = 'report112'
    i = 0;
    @weeks.each do |week|
      i += 1
      cases = Case.find_by_sql("
        SELECT agent_id, count(id) as num from cases where 
        weekofyear(date_lab) = #{week['week']} and year(date_lab) = #{week['year']}  and district_id = #{@district_id}
        group by agent_id, year(date_lab), weekofyear(date_lab), date_lab
      ")
      cases.each do |c|
        if c.agent_id
          report = Report.where(:item_id => c.agent_id).first
          report["col#{i}"] = c.num.to_i
          report.save
        end
      end
    end
    @year = @year.to_i
    median = Case.find_by_sql("
      SELECT agent_id, count(*) as sum, weekofyear(date_lab) as week , year(date_lab) as godina
      from agents
      left join cases on agents.id = cases.agent_id
      where district_id = #{@district_id} and labconfirmed = 1 and weekofyear(date_lab) <= #{@week} and weekofyear(date_lab) > 1 and year(date_lab) = #{@year}
      or  district_id = #{@district_id} and labconfirmed = 1 and weekofyear(date_lab) <= #{@week} and weekofyear(date_lab) > 1 and year(date_lab) = #{@year-1}
      or  district_id = #{@district_id} and labconfirmed = 1 and weekofyear(date_lab) <= #{@week} and weekofyear(date_lab) > 1 and year(date_lab) = #{@year-2}
      group by agents.id, year(date_lab), weekofyear(date_lab), date_lab;
    ")
    tmp = {}

    median.each do |m|
      if !tmp[m.agent_id]
        tmp[m.agent_id] = {}
      end
      if !tmp[m.agent_id][m.godina]
        tmp[m.agent_id][m.godina] = []
      end
      tmp[m.agent_id][m.godina] << m.sum if m.sum
    end

    tmp.each do |agent_id, years|
        i = 9
        years.each do |year,med|
          i -= @year - year
          tmp[agent_id][year] = year_median = Report.median(med)
          report = Report.where(:item_id => agent_id).first
          report["col#{i}"] = year_median
          report["col#{i+3}"] = ((year_median / @district.population) * 100000).round(5) if year_median
          report.save
        end
    end

    Report.all
  end

  def report3
    if (@entity == "9300")
      @total_columns = 3
      @step = 1
    else
      @total_columns = (@entity == "9100")? 7*3 : 10*3
      @step = (@entity == "9100")? 7 : 10
    end
    @districts = District.where(:entity_id => @entity.to_i)
    col_names = {}
    population = {}
    district_list = []
    i=0
    @districts.each do |d|
      i += 1
      col_names[d.id] = i
      population[d.id] = d.population
      district_list << d.id if d.entity_id == @entity.to_i
    end
    district_list_string = "("+district_list.join(',')+")"

    Report.table_name = 'report113'

    query = Case.find_by_sql("
      select icds.id, count(*) as broj, weekofyear(date_of_dg) as week, districts.id as regija
from districts 
inner join cases on districts.id = cases.district_id
inner join icds on icds.id = cases.icd_id
where weekofyear(cases.date_of_dg) <= 26  and weekofyear(cases.date_of_dg) > 1 and year(date_of_dg) = 2013 and cases.district_id IN #{district_list_string}
group by icds.id, year(date_of_dg), weekofyear(date_of_dg), date_of_dg;
    ")
    tmp = {}
    query.each do |q|
      if !tmp[q.id]
        tmp[q.id] = {}
      end
      if !tmp[q.id][q.regija]
        tmp[q.id][q.regija] = { "median" => []}
      end
      tmp[q.id][q.regija]["median"] << q.broj
      if (q.week == @week.to_i)
        tmp[q.id][q.regija]["current"] = q.broj
      end
    end
    @mediana_test = []
    tmp.each do |icd_id, data|
      report = Report2.where(:item_id=>icd_id).first
      data.each do |district_id,mdata|
        colname = col_names[district_id]
        pop = population[district_id]
        report["col#{colname}"] = mdata['current'] if mdata['current']
        report["col#{colname+@step}"] = Report2.median(mdata['median']) if (mdata['median'] and mdata['median'].count >= 1 )
        report["col#{colname+@step*2}"] = (Report2.median(mdata['median'])/pop)*100000 if (mdata['median'] and mdata['median'].count >= 1 )
      end
      report.save
    end
    Report2.all
  end

  def report4
    if (@entity == "9300")
      @total_columns = 3
      @step = 1
    else
      @total_columns = (@entity == "9100")? 7*3 : 10*3
      @step = (@entity == "9100")? 7 : 10
    end
    @districts = District.where(:entity_id => @entity.to_i)
    col_names = {}
    population = {}
    district_list = []
    i=0
    @districts.each do |d|
      i += 1
      col_names[d.id] = i
      population[d.id] = d.population
      district_list << d.id if d.entity_id == @entity.to_i
    end
    district_list_string = "("+district_list.join(',')+")"

    Report.table_name = 'report113'

    query = Case.find_by_sql("
      select agents.id, count(*) as broj, weekofyear(date_lab) as week, districts.id as regija
from districts 
inner join cases on districts.id = cases.district_id
inner join agents on agents.id = cases.agent_id
where weekofyear(cases.date_lab) <= 26  and weekofyear(cases.date_lab) > 1 and year(date_lab) = 2013 and cases.district_id IN #{district_list_string}
group by agents.id, year(date_lab), weekofyear(date_lab), date_lab;
    ")
    tmp = {}
    query.each do |q|
      if !tmp[q.id]
        tmp[q.id] = {}
      end
      if !tmp[q.id][q.regija]
        tmp[q.id][q.regija] = { "median" => []}
      end
      tmp[q.id][q.regija]["median"] << q.broj
      if (q.week == @week.to_i)
        tmp[q.id][q.regija]["current"] = q.broj
      end
    end
    @mediana_test = []
    tmp.each do |agent_id, data|
      report = Report2.where(:item_id=>agent_id).first
      data.each do |district_id,mdata|
        colname = col_names[district_id]
        pop = population[district_id]
        report["col#{colname}"] = mdata['current'] if mdata['current']
        report["col#{colname+@step}"] = Report2.median(mdata['median']) if (mdata['median'] and mdata['median'].count >= 1 )
        report["col#{colname+@step*2}"] = (Report2.median(mdata['median'])/pop)*100000 if (mdata['median'] and mdata['median'].count >= 1 )
      end
      report.save
    end
    Report2.all
  end

  def report5
    @grupe = [
      '0-4',
      '5-14',
      '15-24',
      '25-44',
      '45-64',
      '65+',
    ]
    @step = 6;
    @total_columns = 6*3
    Report2.table_name = 'report113'
    tmp = {}
    i = 0
    col_names = {}
    @grupe.each do |g|
      i += 1
      col_names[g] = i
      period = g.split('-')
      period_sql = period.count == 2 ? "age >= #{period.first.to_i} and age <= #{period.last.to_i}" : "age >= #{period.first.to_i}"
      period_cases = Case.find_by_sql("
        select icds.id as icd_id, count(cases.id) as broj, weekofyear(date_of_dg) as week
        from icds
        inner join cases on icds.id = cases.icd_id
        where weekofyear(date_of_dg) <= #{@week} and weekofyear(date_of_dg) >= 1 and year(date_of_dg) = #{@year} and #{period_sql} 
        group by icds.id, year(date_of_dg), weekofyear(date_of_dg), date_of_dg;
      ")
      
      period_cases.each do |pc|
        if (!tmp[pc.icd_id])
          tmp[pc.icd_id] = {}
        end
        if (!tmp[pc.icd_id][g])
          tmp[pc.icd_id][g] = { "median" => []}
        end
        tmp[pc.icd_id][g]["median"] << pc.broj
        if (pc.week == @week.to_i)
          tmp[pc.icd_id][g]["current"] = pc.broj
        end
      end
    end
    tmp.each do |icd_id, data|
      report = Report2.where(:item_id=>icd_id).first
      data.each do |grupa,mdata|
        colname = col_names[grupa]
        report["col#{colname}"] = mdata['current'] if mdata['current']
        report["col#{colname+@step}"] = Report2.median(mdata['median']) if (mdata['median'] and mdata['median'].count >= 1 )
        report["col#{colname+@step*2}"] = (Report2.median(mdata['median'])/@district.population)*100000 if (mdata['median'] and mdata['median'].count >= 1 )
      end
      report.save
    end


    Report2.all
  end

  def report6
    @grupe = [
      '0-4',
      '5-14',
      '15-24',
      '25-44',
      '45-64',
      '65+',
    ]
    @step = 6;
    @total_columns = 6*3
    Report2.table_name = 'report113'
    tmp = {}
    i = 0
    col_names = {}
    @grupe.each do |g|
      i += 1
      col_names[g] = i
      period = g.split('-')
      period_sql = period.count == 2 ? "age >= #{period.first.to_i} and age <= #{period.last.to_i}" : "age >= #{period.first.to_i}"
      period_cases = Case.find_by_sql("
        select agents.id as agent_id, count(cases.id) as broj, weekofyear(date_lab) as week
        from agents
        inner join cases on agents.id = cases.agent_id
        where weekofyear(date_lab) <= #{@week} and weekofyear(date_lab) >= 1 and year(date_lab) = #{@year} and #{period_sql} 
        group by agents.id, year(date_lab), weekofyear(date_lab), date_lab;
      ")
      
      period_cases.each do |pc|
        if (!tmp[pc.agent_id])
          tmp[pc.agent_id] = {}
        end
        if (!tmp[pc.agent_id][g])
          tmp[pc.agent_id][g] = { "median" => []}
        end
        tmp[pc.agent_id][g]["median"] << pc.broj
        if (pc.week == @week.to_i)
          tmp[pc.agent_id][g]["current"] = pc.broj
        end
      end
    end
    tmp.each do |agent_id, data|
      report = Report2.where(:item_id=>agent_id).first
      data.each do |grupa,mdata|
        colname = col_names[grupa]
        report["col#{colname}"] = mdata['current'] if mdata['current']
        report["col#{colname+@step}"] = Report2.median(mdata['median']) if (mdata['median'] and mdata['median'].count >= 1 )
        report["col#{colname+@step*2}"] = (Report2.median(mdata['median'])/@district.population)*100000 if (mdata['median'] and mdata['median'].count >= 1 )
      end
      report.save
    end


    Report2.all
  end

  def report7
    @icd = Icd.where("id in (105,103,57,47)")
    @tmp = {}
    @icd.each do |icd|
      @tmp[icd.id] = {"name" => icd.name, "bkdd" => 0, "blpd" => 0}
    end
    strasne_dg = Case.find_by_sql("
      select count(cases.id) as broj, weekofyear(cases.date_of_dg) as week, icds.id as icd_id from icds
      inner join cases on icds.id = cases.icd_id
      where weekofyear(cases.date_of_dg) = #{@week} and year(cases.date_of_dg) = #{@year}  and icds.id in  (105,103,57,47)
      group by weekofyear(cases.date_of_dg), icds.id;
    ")
    strasne_dg.each do |s|
      @tmp[s.icd_id]["bkdd"] = s.broj;
    end
    strasne_lab = Case.find_by_sql("
      select count(cases.id) as broj, weekofyear(cases.date_of_dg) as week, icds.id as icd_id from icds
      inner join cases on icds.id = cases.icd_id
      where weekofyear(cases.date_of_dg) = #{@week} and year(cases.date_of_dg) = #{@year}  and icds.id in  (105,103,57,47) and labconfirmed = 1
      group by weekofyear(cases.date_of_dg), icds.id;
    ")
    strasne_lab.each do |s|
      @tmp[s.icd_id]["blpd"] = s.broj;
    end
    @tmp

  end


  def prepare_reports_tables
    #report 1.1.1
    if (@r == 1)
      Report.table_name = 'report111'
      Report.delete_all
      main_icd = Icd.where(:int => 0)
      main_icd.each do |micd|
        row = Report.new
        row.item_id = micd.id
        row.name = micd.disease_bsn
        (1..12).each do |i|
          row['col'+i.to_s] = nil
        end
        row.save
        childs = Icd.where(:int => micd.id)
        childs.each do |cicd|
          row = Report.new
          row.item_id = cicd.id
          row.name = cicd.code + " " + cicd.disease_bsn
          row.save
        end

      end
    elsif @r == 2
      #report 1.1.2
      Report.table_name = 'report112'
      Report.delete_all
      agents = Agent.all
      agents.each do |agent|
        row = Report.new
        row.name = agent.agent
        row.item_id = agent.id
        row.save
      end
    elsif @r == 3 || @r == 5
      #report 1.1.3
      Report2.table_name = 'report113'
      Report2.delete_all
      main_icd = Icd.where(:int => 0)
      main_icd.each do |micd|
        row = Report2.new
        row.item_id = micd.id
        row.name = micd.disease_bsn
        (1..30).each do |i|
          row["col#{i}"] = nil
        end
        row.save
        childs = Icd.where(:int => micd.id)
        childs.each do |cicd|
          row = Report2.new
          row.item_id = cicd.id
          row.name = cicd.code + " " + cicd.disease_bsn
          row.save
        end

      end
    elsif @r == 4 || @r == 6
      #report 1.1.4
      Report2.table_name = 'report113'
      Report2.delete_all
      agents = Agent.all
      agents.each do |agent|
        row = Report2.new
        row.name = agent.agent
        row.item_id = agent.id
        row.save
      end
    end
  end


end
