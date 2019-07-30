Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380F6C433FF
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 23:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088242067D
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 23:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfG3Xh0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:37:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbfG3Xh0 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 30 Jul 2019 19:37:26 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UNbEKl144401
        for <rcu@vger.kernel.org>; Tue, 30 Jul 2019 19:37:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2tyka5jg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Tue, 30 Jul 2019 19:37:25 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 31 Jul 2019 00:37:24 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 00:37:20 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UNbJAJ24904096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 23:37:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44932B206A;
        Tue, 30 Jul 2019 23:37:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23ADCB2066;
        Tue, 30 Jul 2019 23:37:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.181.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jul 2019 23:37:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3CF2416C99B9; Tue, 30 Jul 2019 16:37:20 -0700 (PDT)
Date:   Tue, 30 Jul 2019 16:37:20 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 25/26] docs: rcu: convert some articles from html to
 ReST
Reply-To: paulmck@linux.ibm.com
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
 <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
 <20190730212250.GJ14271@linux.ibm.com>
 <20190730185040.3fbc44ca@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730185040.3fbc44ca@coco.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19073023-0064-0000-0000-000004049405
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011525; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01239809; UDB=6.00653730; IPR=6.01021221;
 MB=3.00027966; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-30 23:37:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073023-0065-0000-0000-00003E7AFB9E
Message-Id: <20190730233720.GL14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300239
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 30, 2019 at 06:50:51PM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 30 Jul 2019 14:22:50 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:
> 
> > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
> > > There are 4 RCU articles that are written on html format.
> > > 
> > > The way they are, they can't be part of the Linux Kernel
> > > documentation body nor share the styles and pdf output.
> > > 
> > > So, convert them to ReST format.
> > > 
> > > This way, make htmldocs and make pdfdocs will produce a
> > > documentation output that will be like the original ones, but
> > > will be part of the Linux Kernel documentation body.
> > > 
> > > Part of the conversion was done with the help of pandoc, but
> > > the result had some broken things that had to be manually
> > > fixed.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> > 
> > I am having some trouble applying these, at least in part due to UTF-8
> > sequences, for example double left quotation mark.  These end up being
> > "=E2=80=9C", with a few space characters turned into "=20".
> > 
> > Any advice on how to apply these?
> 
> Didn't notice it ended with UTF-8 chars. It is probably because it came
> from the html conversion.

Or maybe there are some email issues somewhere along the way.

> I guess it shouldn't hurt keeping those, but if you prefer I can find 
> some time later to replace them.
> 
> > Should I just pull commits from somewhere?
> 
> Yeah, if you prefer, you can pull from this branch:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=rcu-v1
> 
> It has just two patches: the RCU and tools/memory-model ones.
> 
> It is based on v5.3-rc2.

And that does apply, thank you!

							Thanx, Paul

