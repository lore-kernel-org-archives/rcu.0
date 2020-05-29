Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457FC433E0
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8502074B
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 09:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NNFc0dmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgE2Jsk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 05:48:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52530 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgE2Jsj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 05:48:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T9mTHE133610;
        Fri, 29 May 2020 09:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=YES9ox3Y8ee63xXVrA8NY1VlmGE0TY+PSNFvsxa86rQ=;
 b=NNFc0dmYXQEp2jd4J1KAEOELWAg+miZPbqLT2bhkCNdRff+scZLsWhLc1l6Q2XRlLckX
 yN2uH3B2jbWufUtxFdBQ7PQtceHidN/girT8ywEP7ReMSjKrjvKI1T5PYKLW/pVa/LLr
 5A44SS4oCdqhRHtV8hJwfCyr0PGdj7XjMVlf64e1iMC9mKkYgEN6SRFNEVR6rras4HdZ
 0KapiZkiQKVVX/py7pCx0TyNjDvaGluOpUBJ6CRdKDZufhGj7cGAP74S9wh8weh2b9XI
 yRkSGeJ2KneERpR4WRrekH0o93atJBehEYG22/CqlpFu5VvfDfPWqG7pPfBHLDatM7Un Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 318xe1sgdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 09:48:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T9liZL185197;
        Fri, 29 May 2020 09:48:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31a9ku0n8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 09:48:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04T9mZZ3008404;
        Fri, 29 May 2020 09:48:35 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 02:48:34 -0700
Date:   Fri, 29 May 2020 12:48:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Subject: [bug report] refperf: Dynamically allocate experiment-summary output
 buffer
Message-ID: <20200529094829.GA1302781@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=3 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290078
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Paul E. McKenney,

This is a semi-automatic email about new static checker warnings.

The patch 54c0ed208976: "refperf: Dynamically allocate
experiment-summary output buffer" from May 25, 2020, leads to the
following Smatch complaint:

    kernel/rcu/refperf.c:395 main_func()
    error: we previously assumed 'buf' could be null (see line 352)

kernel/rcu/refperf.c
   351		buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
   352		if (!result_avg || !buf) {
                                   ^^^^
Check for NULL

   353			VERBOSE_PERFOUT_ERRSTRING("out of memory");
   354			errexit = true;
   355		}
   356		atomic_inc(&n_init);
   357	
   358		// Wait for all threads to start.
   359		wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
   360	
   361		// Start exp readers up per experiment
   362		for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
   363			if (errexit)
   364				break;
   365			if (torture_must_stop())
   366				goto end;
   367	
   368			reset_readers();
   369			atomic_set(&nreaders_exp, nreaders);
   370	
   371			exp_idx = exp;
   372	
   373			for (r = 0; r < nreaders; r++) {
   374				atomic_set(&reader_tasks[r].start, 1);
   375				wake_up(&reader_tasks[r].wq);
   376			}
   377	
   378			VERBOSE_PERFOUT("main_func: experiment started, waiting for %d readers",
   379					nreaders);
   380	
   381			wait_event(main_wq,
   382				   !atomic_read(&nreaders_exp) || torture_must_stop());
   383	
   384			VERBOSE_PERFOUT("main_func: experiment ended");
   385	
   386			if (torture_must_stop())
   387				goto end;
   388	
   389			result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
   390		}
   391	
   392		// Print the average of all experiments
   393		PERFOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
   394	
   395		buf[0] = 0;
                ^^^^^^
Unchecked dereferences.

   396		strcat(buf, "\n");
   397		strcat(buf, "Threads\tTime(ns)\n");

regards,
dan carpenter
