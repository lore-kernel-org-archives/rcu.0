Return-Path: <SRS0=275B=V4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C9C32750
	for <rcu@archiver.kernel.org>; Wed, 31 Jul 2019 00:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DB32089E
	for <rcu@archiver.kernel.org>; Wed, 31 Jul 2019 00:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfGaAF3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:05:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728130AbfGaAF3 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 30 Jul 2019 20:05:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V01q89190037;
        Tue, 30 Jul 2019 20:04:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u2wspcfup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 20:04:56 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6V039Iv194200;
        Tue, 30 Jul 2019 20:04:56 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u2wspcfue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 20:04:56 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6V00Ydw031364;
        Wed, 31 Jul 2019 00:04:55 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2u0e85uqab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 00:04:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6V04sRd11993638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 00:04:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77CDEB2067;
        Wed, 31 Jul 2019 00:04:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43ADBB206A;
        Wed, 31 Jul 2019 00:04:54 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.181.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 31 Jul 2019 00:04:54 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 63D3516C0485; Tue, 30 Jul 2019 17:04:55 -0700 (PDT)
Date:   Tue, 30 Jul 2019 17:04:55 -0700
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
Message-ID: <20190731000455.GA11465@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
 <8444797277eea7be474f40625bb190775a9cee33.1564145354.git.mchehab+samsung@kernel.org>
 <20190730212250.GJ14271@linux.ibm.com>
 <20190730185040.3fbc44ca@coco.lan>
 <20190730233720.GL14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730233720.GL14271@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300244
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 30, 2019 at 04:37:20PM -0700, Paul E. McKenney wrote:
> On Tue, Jul 30, 2019 at 06:50:51PM -0300, Mauro Carvalho Chehab wrote:
> > Em Tue, 30 Jul 2019 14:22:50 -0700
> > "Paul E. McKenney" <paulmck@linux.ibm.com> escreveu:
> > 
> > > On Fri, Jul 26, 2019 at 09:51:35AM -0300, Mauro Carvalho Chehab wrote:
> > > > There are 4 RCU articles that are written on html format.
> > > > 
> > > > The way they are, they can't be part of the Linux Kernel
> > > > documentation body nor share the styles and pdf output.
> > > > 
> > > > So, convert them to ReST format.
> > > > 
> > > > This way, make htmldocs and make pdfdocs will produce a
> > > > documentation output that will be like the original ones, but
> > > > will be part of the Linux Kernel documentation body.
> > > > 
> > > > Part of the conversion was done with the help of pandoc, but
> > > > the result had some broken things that had to be manually
> > > > fixed.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> > > 
> > > I am having some trouble applying these, at least in part due to UTF-8
> > > sequences, for example double left quotation mark.  These end up being
> > > "=E2=80=9C", with a few space characters turned into "=20".
> > > 
> > > Any advice on how to apply these?
> > 
> > Didn't notice it ended with UTF-8 chars. It is probably because it came
> > from the html conversion.
> 
> Or maybe there are some email issues somewhere along the way.
> 
> > I guess it shouldn't hurt keeping those, but if you prefer I can find 
> > some time later to replace them.
> > 
> > > Should I just pull commits from somewhere?
> > 
> > Yeah, if you prefer, you can pull from this branch:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=rcu-v1
> > 
> > It has just two patches: the RCU and tools/memory-model ones.
> > 
> > It is based on v5.3-rc2.
> 
> And that does apply, thank you!

And "make htmldocs" does produce real HTML!  At first glance anyway,
quite impressive.

However, "make pdfdocs" gives me this complaint:

	! Dimension too large.
	\color@b@x ... #3}\kern \fboxsep }\dimen@ \ht \z@ 
							  \advance \dimen@ \fboxsep ...
	l.5092 \end{sphinxVerbatim}

This appears to come from Documentation/output/latex/RCU.tex.
There is nevertheless an RCU.pdf in this directory.  It is not
bad, but has a figure full of XML on PDF page 21.  And a few later
on as well.

On the HTML side, the quick quizzes have immediately visible answers,
which defeats the purpose.  The original HTML used a white font,
so that you selected the answer with your mouse to make it visible.
Can something similar be done with Sphinx?  Another approach is to
gather the answers into a separate file and link to them.

I believe that Joel already noted that internal links are not working.
The external links that I tried work just fine, though.  As do the
links from the table of contents.

							Thanx, Paul
