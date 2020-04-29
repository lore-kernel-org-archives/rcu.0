Return-Path: <SRS0=QSVt=6N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB70C83003
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BBC2087E
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 13:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zD027TPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgD2NYL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:24:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44498 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgD2NYL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Apr 2020 09:24:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TDNM4k138386;
        Wed, 29 Apr 2020 13:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=dC8hfm5Zl6acTseNn/Ky2gyzqj6BCdYSqNLoFwTIlpY=;
 b=zD027TPuj6p9xFC4r8nd52giO1vOFrluEjAXuXV6QxWLRAvViUY9qESJQ1aPwd3XMc/j
 2cn5qc0VGK/yMvUEovpnKHpbmJeQiYsS+p7RRt3APWYrSb7X8nge/aSnyhrLsvaO/K3u
 f2cktVtIQ690217RZuBovzDpuYi9cgxd++Tjoz9yOtwws0dYPR83hOD2Q1xlzZfTUg1n
 iatGjtr+xtoajKshkecPMVCwKRs+mfXpwDbedHllSJwGOxJwzGUlWkbROupg5Uci1fm8
 EdCDwjgyUTGmQdV07YjoPPNUPFDW6UurjNKkrKLb5Url65PHyOJ6yIsMqpoW/5+Tq8rE mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p0b3na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:24:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TDMku4107434;
        Wed, 29 Apr 2020 13:24:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30mxpk19vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 13:24:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03TDO84h006301;
        Wed, 29 Apr 2020 13:24:08 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 06:24:07 -0700
Date:   Wed, 29 Apr 2020 16:24:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Subject: [bug report] rcutorture: Add races with task-exit processing
Message-ID: <20200429132402.GD815283@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=3 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290113
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello Paul E. McKenney,

The patch e02882cd57e3: "rcutorture: Add races with task-exit
processing" from Apr 24, 2020, leads to the following static checker
warning:

	kernel/rcu/rcutorture.c:2429 rcu_torture_read_exit()
	warn: 'rep' was already freed.

kernel/rcu/rcutorture.c
  2369  static int rcu_torture_read_exit(void *unused)
  2370  {
  2371          int count = 0;
  2372          bool errexit = false;
  2373          int i;
  2374          struct task_struct **rep;
  2375          struct torture_random_state *trsp;
  2376  
  2377          // Allocate and initialize.
  2378          set_user_nice(current, MAX_NICE);
  2379          rep = kcalloc(read_exit, sizeof(*rep), GFP_KERNEL);
  2380          trsp = kcalloc(read_exit, sizeof(*trsp), GFP_KERNEL);
  2381          if (rep && trsp) {
  2382                  for (i = 0; i < read_exit; i++)
  2383                          torture_random_init(&trsp[i]);
  2384                  VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of test");
  2385          } else {
  2386                  kfree(rep);
                              ^^^
  2387                  kfree(trsp);
                              ^^^^
Freed.

  2388                  errexit = true;
  2389                  VERBOSE_TOROUT_ERRSTRING("out of memory");
  2390          }
  2391  
  2392          // Each pass through this loop does one read-exit episode.
  2393          while (!errexit && ! READ_ONCE(read_exit_child_stop)) {
  2394                  if (++count > read_exit_burst) {
  2395                          VERBOSE_TOROUT_STRING("rcu_torture_read_exit: End of episode");
  2396                          schedule_timeout_uninterruptible(HZ * read_exit_delay);
  2397                          VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of episode");
  2398                          count = 0;
  2399                  }
  2400                  // Spawn children.
  2401                  for (i = 0; i < read_exit && i <= num_online_cpus(); i++) {
  2402                          // We don't want per-child console messages.
  2403                          rep[i] = kthread_run(rcu_torture_read_exit_child,
  2404                                               &trsp[i], "%s",
  2405                                               "rcu_torture_read_exit_child");
  2406                          if (IS_ERR(rep[i])) {
  2407                                  VERBOSE_TOROUT_ERRSTRING("out of memory");
  2408                                  errexit = true;
  2409                                  rep[i] = NULL;
  2410                                  break;
  2411                          }
  2412                          cond_resched();
  2413                  }
  2414                  n_read_exits += i;
  2415                  // Reap children.
  2416                  for (i--; i >= 0; i--) {
  2417                          kthread_stop(rep[i]);
  2418                          rep[i] = NULL;
  2419                          cond_resched();
  2420                  }
  2421                  rcu_barrier(); // Wait for task_struct freeing, avoid OOM.
  2422                  stutter_wait("rcu_torture_read_exit");
  2423          }
  2424  
  2425          // Clean up and exit.
  2426          smp_store_release(&read_exit_child_stopped, true); // After reaping.
  2427          smp_mb(); // Store before wakeup.
  2428          wake_up(&read_exit_wq);
  2429          kfree(rep);
                      ^^^
  2430          kfree(trsp);
                      ^^^^
Double freed.

  2431          while (!torture_must_stop())
  2432                  schedule_timeout_uninterruptible(1);
  2433          torture_kthread_stopping("rcu_torture_read_exit");
  2434          return 0;
  2435  }

regards,
dan carpenter
