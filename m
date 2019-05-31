Return-Path: <SRS0=q/VE=T7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFBC04AB6
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 19:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1614626E22
	for <rcu@archiver.kernel.org>; Fri, 31 May 2019 19:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEaTAa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 May 2019 15:00:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726579AbfEaTAa (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 31 May 2019 15:00:30 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VIwOiG074522
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 15:00:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2su7nadgw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Fri, 31 May 2019 15:00:28 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 31 May 2019 20:00:27 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 31 May 2019 20:00:25 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4VJ0OZm38600910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 19:00:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49ABCB206A;
        Fri, 31 May 2019 19:00:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36F4AB206B;
        Fri, 31 May 2019 19:00:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 31 May 2019 19:00:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A01C016C37A7; Fri, 31 May 2019 12:00:25 -0700 (PDT)
Date:   Fri, 31 May 2019 12:00:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcuperf: correct a example of perf_type
Reply-To: paulmck@linux.ibm.com
References: <1559315745-26570-1-git-send-email-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559315745-26570-1-git-send-email-ice_yangxiao@163.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19053119-0072-0000-0000-00000435F192
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011192; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01211343; UDB=6.00636494; IPR=6.00992380;
 MB=3.00027135; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-31 19:00:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053119-0073-0000-0000-00004C6ECC5B
Message-Id: <20190531190025.GP28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-31_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310114
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 31, 2019 at 11:15:45PM +0800, Xiao Yang wrote:
> rcu_bh type has been removed by commit 620d246065cd("rcuperf:
> Remove the "rcu_bh" and "sched" torture types") and only four
> types(i.e rcu, srcu, srcud, tasks) are supported currently, so
> use srcu as a example.
> 
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>

Good eyes, applied!

I edited the subject and commit log as shown below.  Could you please
check to make sure that I didn't mess something up?

							Thanx, Paul

------------------------------------------------------------------------

commit f499b80f236316c5f16c4d5c0d7804c258a003cb
Author: Xiao Yang <ice_yangxiao@163.com>
Date:   Fri May 31 23:15:45 2019 +0800

    rcuperf: Fix perf_type module-parameter description
    
    The rcu_bh rcuperf type was removed by commit 620d246065cd("rcuperf:
    Remove the "rcu_bh" and "sched" torture types"), but it lives on in the
    MODULE_PARM_DESC() of perf_type.  This commit therefore changes that
    module-parameter description to substitute srcu for rcu_bh.
    
    Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b23c5f..4513807cd4c4 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -89,7 +89,7 @@ torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, rcu_bh, ...)");
+MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, srcu, ...)");
 
 static int nrealreaders;
 static int nrealwriters;

