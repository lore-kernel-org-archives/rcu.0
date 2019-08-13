Return-Path: <SRS0=0MOJ=WJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A0C31E40
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 02:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604702067D
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 02:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfHMCvB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 22:51:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfHMCvB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 12 Aug 2019 22:51:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D2llCK142409;
        Mon, 12 Aug 2019 22:50:59 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ubg6hg6kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 22:50:59 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7D2oBr9003683;
        Tue, 13 Aug 2019 02:50:58 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 2u9nj62bf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 02:50:58 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7D2ovOd51380506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 02:50:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9145B2064;
        Tue, 13 Aug 2019 02:50:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89864B205F;
        Tue, 13 Aug 2019 02:50:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.215.124])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 02:50:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3BC6116C0AC3; Mon, 12 Aug 2019 19:50:57 -0700 (PDT)
Date:   Mon, 12 Aug 2019 19:50:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190813025057.GY28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190813022726.GW28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813022726.GW28441@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=727 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130029
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 07:27:26PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> > On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:

[ . . . ]

> > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > (rcu_dynticks_curr_cpu_in_eqs())".
> 
> It might well make sense to do this on entry, especially if doing so
> might safe an instruction or two.  It won't make the tick happen much
> faster, given that interrupts are disabled throughout the handler.
> 
> > I will test this patch tomorrow and let you know how it goes.
> 
> No need, it dies horribly and quickly with rcutorture.  Not exactly
> a surprise.  ;-)

And also not a surprise, due to a laughably stupid mistake...

							Thanx, Paul
