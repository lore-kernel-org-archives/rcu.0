Return-Path: <SRS0=0MOJ=WJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD9C433FF
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 02:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A7B206A2
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 02:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfHMC2f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 22:28:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbfHMC2f (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 12 Aug 2019 22:28:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D2RDtc109449
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 22:28:34 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubg8u7by0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 22:28:33 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 13 Aug 2019 03:28:33 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Aug 2019 03:28:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7D2STal23396744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 02:28:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D260CB2065;
        Tue, 13 Aug 2019 02:28:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F3CB2064;
        Tue, 13 Aug 2019 02:28:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.215.124])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 02:28:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 60DF616C1109; Mon, 12 Aug 2019 19:28:29 -0700 (PDT)
Date:   Mon, 12 Aug 2019 19:28:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Reply-To: paulmck@linux.ibm.com
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190813010525.GB129011@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813010525.GB129011@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081302-0072-0000-0000-000004522917
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011586; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246008; UDB=6.00657500; IPR=6.01027512;
 MB=3.00028154; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-13 02:28:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081302-0073-0000-0000-00004CC33B12
Message-Id: <20190813022829.GX28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130025
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 09:05:25PM -0400, Joel Fernandes wrote:
> On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> [snip]
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 8c494a692728..ad906d6a74fb 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > >  	 */
> > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > > +		    rdp->dynticks_nmi_nesting == 2 &&
> > > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > +			rdp->rcu_forced_tick = true;
> > > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > +		}
> > 
> > 
> > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > (rcu_dynticks_curr_cpu_in_eqs())".
> 
> Actually, the other way. if (!rcu_dynticks_curr_cpu_in_eqs()) then do the
> tick_dep_set_cpu().

That does sound more likely.  Still, need to work out what the
breakage is.

							Thanx, Paul

