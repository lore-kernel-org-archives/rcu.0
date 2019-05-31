Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320CC04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415A526767
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 13:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaNwO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 09:52:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfEaNwO (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 31 May 2019 09:52:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VDqCxI116209
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 09:52:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2su4wssmfe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 09:52:12 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 31 May 2019 14:52:09 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 14:52:06 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4VDooXZ37683678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 13:50:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 271A6B2064;
        Fri, 31 May 2019 13:50:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ADA1B2067;
        Fri, 31 May 2019 13:50:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 13:50:49 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 24D6716C35A1; Fri, 31 May 2019 06:50:51 -0700 (PDT)
Date:   Fri, 31 May 2019 06:50:51 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Dumazet <edumazet@google.com>, rcu <rcu@vger.kernel.org>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053113-0052-0000-0000-000003C99C03
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011190; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211240; UDB=6.00636432; IPR=6.00992277;
 MB=3.00027132; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-31 13:52:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053113-0053-0000-0000-0000611CD88C
Message-Id: <20190531135051.GL28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310088
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 31, 2019 at 09:10:16AM -0400, Joel Fernandes wrote:
> Hi,
> As per the documentation for rationale of percpu-rwsem, the Documentation says:
> 
> The problem with traditional read-write semaphores is that when multiple
> cores take the lock for reading, the cache line containing the semaphore
> is bouncing between L1 caches of the cores, causing performance
> degradation.
> 
> However, it appears to me that the struct percpu_rwsem "rss" element
> which is used by the RCU-sync is not a per-cpu element. So even in the
> fastpath case (only readers and no writers), the cacheline containing
> rss is shared and will bounce by multiple CPUs. For that matter, even
> the cacheline containing the percpu_rw_semaphore itself will be bounce
> among multiple reader CPUs.
> 
> So how does percpu-rwsem eliminate cache line bouncing in the common
> case. Could you let me know what I am missing?
> 
> Thanks a lot.

The accesses are loads, except for the __this_cpu_inc(), which updates
a per-CPU variable.  The locations loaded will replicate across the
CPUs' caches and the per-CPU variables are private to each CPU.  Hence
no cacheline bouncing.

Or am I missing the point of your question?

Either way, it would be good for you to just try it.  Create a kernel
module or similar than hammers on percpu_down_read() and percpu_up_read(),
and empirically check the scalability on a largish system.  Then compare
this to down_read() and up_read()

							Thanx, Paul

