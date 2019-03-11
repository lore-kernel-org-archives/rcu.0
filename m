Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8AC43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 22:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FF92087C
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 22:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfCKWJe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727138AbfCKWJe (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 11 Mar 2019 18:09:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BM9TE0071298
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 18:09:33 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r5xj440g5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 18:09:32 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Mar 2019 22:09:31 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 22:09:28 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BM9RNY11534358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 22:09:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A4CFB2085;
        Mon, 11 Mar 2019 22:09:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C896B2080;
        Mon, 11 Mar 2019 22:09:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 22:09:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5D43816C34A1; Mon, 11 Mar 2019 15:09:29 -0700 (PDT)
Date:   Mon, 11 Mar 2019 15:09:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcuupdate: Do a single rhp->func read in
 rcu_head_after_call_rcu
Reply-To: paulmck@linux.ibm.com
References: <1552305483-15846-1-git-send-email-neeraju@codeaurora.org>
 <20190311154839.GH13351@linux.ibm.com>
 <f4e04233-c0ef-f592-a4dc-23d659171396@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e04233-c0ef-f592-a4dc-23d659171396@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031122-0060-0000-0000-0000031A81E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010741; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01172997; UDB=6.00613254; IPR=6.00953652;
 MB=3.00025936; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-11 22:09:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031122-0061-0000-0000-00004893D929
Message-Id: <20190311220929.GA22895@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110151
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 11, 2019 at 09:22:30PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 3/11/19 9:18 PM, Paul E. McKenney wrote:
> >On Mon, Mar 11, 2019 at 05:28:03PM +0530, Neeraj Upadhyay wrote:
> >>Read rhp->func pointer in rcu_head_after_call_rcu() only once,
> >>to avoid warning in the case, where call_rcu() happens between
> >>two reads of rhp->func.
> >>
> >>Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> >
> >This would more gracefully handle racing rcu_head_after_call_rcu()
> >with call_rcu().
> >
> >But this thing is not yet used, so let's see what Neil Brown says.
> >If he isn't going to use it, my thought is to instead just remove
> >this.
> 
> Agree, makes sense.

And Neil said that he intends to use it, so I applied your patch, updated
as shown below.  Ah, and please use scripts/checkpatch.pl -- it sometimes
gets overly enthusiastic, but the blank line following the declarations is
good practice.

							Thanx, Paul

------------------------------------------------------------------------

commit fcf4326ee3fb7e0925fe0f299c385c31f5d62fbf
Author: Neeraj Upadhyay <neeraju@codeaurora.org>
Date:   Mon Mar 11 17:28:03 2019 +0530

    rcu: Do a single rhp->func read in rcu_head_after_call_rcu()
    
    The rcu_head_after_call_rcu() function reads the rhp->func pointer twice,
    which can result in a false-positive WARN_ON_ONCE() if the callback
    were passed to call_rcu() between the two reads.  Although racing
    rcu_head_after_call_rcu() with call_rcu() is to be a dubious use case
    (the return value is not reliable in that case), intermittent and
    irreproducible warnings are also quite dubious.  This commit therefore
    uses a single READ_ONCE() to pick up the value of rhp->func once, then
    tests that value twice, thus guaranteeing consistent processing within
    rcu_head_after_call_rcu()().
    
    Neverthless, racing rcu_head_after_call_rcu() with call_rcu() is still
    a dubious use case.
    
    Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    [ paulmck: Add blank line after declaration per checkpatch.pl. ]
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6cdb1db776cf..922bb6848813 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -878,9 +878,11 @@ static inline void rcu_head_init(struct rcu_head *rhp)
 static inline bool
 rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 {
-	if (READ_ONCE(rhp->func) == f)
+	rcu_callback_t func = READ_ONCE(rhp->func);
+
+	if (func == f)
 		return true;
-	WARN_ON_ONCE(READ_ONCE(rhp->func) != (rcu_callback_t)~0L);
+	WARN_ON_ONCE(func != (rcu_callback_t)~0L);
 	return false;
 }
 

