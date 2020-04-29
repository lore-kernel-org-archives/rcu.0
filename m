Return-Path: <SRS0=QSVt=6N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D8C83000
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFE92083B
	for <rcu@archiver.kernel.org>; Wed, 29 Apr 2020 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iB/q9ZiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgD2RpU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:45:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38306 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2RpT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Apr 2020 13:45:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03THTNFW087268;
        Wed, 29 Apr 2020 17:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hnvi7F28/DNd1RRwkWDCYRoMBlVHF0pPO2Nr7fWazds=;
 b=iB/q9ZiFF+gC+LA4B21r97ZePPQc1Rrp81UWDfdfy2rkMewvDFxMy0GFpGOXmqJXSdih
 f8czvKHA65r7JuWF8AMa2/oyzg2TQGUg5DXwmBtFFo58A8Y56lngROF/VRdr3sNHxsOT
 y6dVGDimPgB/cbuDZb3R9DdJnfar7qdM7n6YYPENRGAoiDrcL/laoQh7+6kkxXS2v388
 y7nTDULeSc/LVhExm/Ca0e0ComQIP6wUjh4ebyKJqaWrdy1aQgFfa7xnHk5B3UlvdkWN
 C5pJkS/bj7Rdhv3gf3CuIgGys05OC8fGnSPUNURzYXxQEaNQRRPXevWz3Mdsyq0ONImN OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30p01nwr8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 17:45:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03THc6HT168489;
        Wed, 29 Apr 2020 17:43:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30pvd1hatw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 17:43:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03THhG3m018928;
        Wed, 29 Apr 2020 17:43:16 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 10:43:14 -0700
Date:   Wed, 29 Apr 2020 20:43:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Add races with task-exit processing
Message-ID: <20200429174307.GC1992@kadam>
References: <20200429132402.GD815283@mwanda>
 <20200429154421.GA7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429154421.GA7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290136
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 29, 2020 at 08:44:21AM -0700, Paul E. McKenney wrote:
> On Wed, Apr 29, 2020 at 04:24:02PM +0300, Dan Carpenter wrote:
> > Hello Paul E. McKenney,
> > 
> > The patch e02882cd57e3: "rcutorture: Add races with task-exit
> > processing" from Apr 24, 2020, leads to the following static checker
> > warning:
> > 
> > 	kernel/rcu/rcutorture.c:2429 rcu_torture_read_exit()
> > 	warn: 'rep' was already freed.
> 
> Ah, good catch, will fix!
> 
> > kernel/rcu/rcutorture.c
> >   2369  static int rcu_torture_read_exit(void *unused)
> >   2370  {
> >   2371          int count = 0;
> >   2372          bool errexit = false;
> >   2373          int i;
> >   2374          struct task_struct **rep;
> >   2375          struct torture_random_state *trsp;
> >   2376  
> >   2377          // Allocate and initialize.
> >   2378          set_user_nice(current, MAX_NICE);
> >   2379          rep = kcalloc(read_exit, sizeof(*rep), GFP_KERNEL);
> >   2380          trsp = kcalloc(read_exit, sizeof(*trsp), GFP_KERNEL);
> >   2381          if (rep && trsp) {
> >   2382                  for (i = 0; i < read_exit; i++)
> >   2383                          torture_random_init(&trsp[i]);
> >   2384                  VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of test");
> >   2385          } else {
> >   2386                  kfree(rep);
> >                               ^^^
> >   2387                  kfree(trsp);
> >                               ^^^^
> > Freed.
> 
> And setting both rep and trsp to NULL here takes care of this, correct?
> As in kfree(NULL) is a no-op.  Or is your tool more strict?

Yes, yes.  Setting it to NULL works.  I thought about that, or returning
and I wasn't sure which was prefered.

regards,
dan carpenter

