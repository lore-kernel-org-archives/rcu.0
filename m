Return-Path: <SRS0=Ve56=TG=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EA4C04A6B
	for <rcu@archiver.kernel.org>; Mon,  6 May 2019 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628B820830
	for <rcu@archiver.kernel.org>; Mon,  6 May 2019 23:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfEFXye (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 May 2019 19:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726236AbfEFXyd (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 6 May 2019 19:54:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46NqQIE016582
        for <rcu@vger.kernel.org>; Mon, 6 May 2019 19:54:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2saudayphh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Mon, 06 May 2019 19:54:32 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 7 May 2019 00:54:32 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 May 2019 00:54:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46NsSiM41419102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 23:54:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1183B2066;
        Mon,  6 May 2019 23:54:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5481B2064;
        Mon,  6 May 2019 23:54:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 23:54:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3E1A216C6094; Mon,  6 May 2019 16:54:30 -0700 (PDT)
Date:   Mon, 6 May 2019 16:54:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Should list_entry_rcu use rcu_dereference ?
Reply-To: paulmck@linux.ibm.com
References: <20190504185944.GA79652@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504185944.GA79652@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050623-0060-0000-0000-0000033C0624
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011062; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199621; UDB=6.00629368; IPR=6.00980498;
 MB=3.00026763; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-06 23:54:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050623-0061-0000-0000-0000493F8DB0
Message-Id: <20190506235430.GA3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060180
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, May 04, 2019 at 02:59:44PM -0400, Joel Fernandes wrote:
> Hi,
> Sorry if this is a silly question.

Not at all silly!

> Looking at the list_entry_rcu primitive, I see it does direct READ_ONCE
> on ptr. That's Ok, but rcu_dereference also does additional lockdep and
> sparse checking.  Why not call rcu_dereference instead of READ_ONCE? The
> pointer may be dereference by the caller so IMO makes sense to check.
> 
> Here is the definition of list_entry_rcu:
> /**
>  * list_entry_rcu - get the struct for this entry
>  [snip]
> * This primitive may safely run concurrently with the _rcu list-mutation
>  * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
>  */
> #define list_entry_rcu(ptr, type, member) \
> 	container_of(READ_ONCE(ptr), type, member)
> 
> Also, I was curious why hlist_for_each_entry_rcu() uses rcu_dereference_raw()
> while __hlist_for_each_rcu)_ uses rcu_dereference(). I feel both should use
> rcu_dereference to have the lockdep checking. Is this not done due to
> performance reasons?
> 
> thanks!
> 
>   - Joel
> 
> https://cdn-images-1.medium.com/max/1600/0*XTYvSNj_rT2UZwfm.png

The issue is that most of the RCU list macros are generic over the RCU
read-side flavors.  We could have created _bh and _sched variants of all
of these, but that seemed like way too much RCU API expansion at the time,
and still does.  This shows up in the sparse checking as well, so that
there is just __rcu instead of also being __rcu_bh and __rcu_sched.

Or are do you have a trick in mind that would allow lockdep checking
without RCU API expansion?

							Thanx, Paul

