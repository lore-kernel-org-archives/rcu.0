Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31459C48BD5
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0108B2080C
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfFYVSW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:18:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfFYVSW (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Jun 2019 17:18:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PL6Wt3110601;
        Tue, 25 Jun 2019 17:17:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbrybdhvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 17:17:42 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5PL6aiD111165;
        Tue, 25 Jun 2019 17:17:41 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbrybdhvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 17:17:41 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5PL9h0e023875;
        Tue, 25 Jun 2019 21:17:41 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 2t9by6ttdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 21:17:40 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PLHe6n49217836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 21:17:40 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 334A8B2066;
        Tue, 25 Jun 2019 21:17:40 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 150F2B205F;
        Tue, 25 Jun 2019 21:17:40 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 21:17:40 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8020816C2F90; Tue, 25 Jun 2019 14:17:40 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:17:40 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v3 5/6] Documentation: RCU: Add
 links to rcu.rst
Message-ID: <20190625211740.GQ26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
 <20190625062627.26378-6-c0d1n61at3@gmail.com>
 <20190625155623.GA26519@linux.ibm.com>
 <20190625150155.5c9b8880@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625150155.5c9b8880@lwn.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250163
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 25, 2019 at 03:01:55PM -0600, Jonathan Corbet wrote:
> On Tue, 25 Jun 2019 08:56:23 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > > -  See the UP.txt file in this directory.
> > > +  See :ref:`up_rcu` for more information.  
> > 
> > This rendered as straight text after "make htmldocs" instead of producing
> > a link in the HTML output.  The HTML itself is:
> > 
> > 	<span class="xref std std-ref">up_rcu</span>
> > 
> > This doesn't look like something that would create a link, though I
> > freely admit that my HTML is rather outdated.
> 
> The problem is that the reference target isn't called "up_rcu" in the file
> itself:
> 
> > diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.txt
> > index 53bde717017b..67715a47ae89 100644
> > --- a/Documentation/RCU/UP.txt
> > +++ b/Documentation/RCU/UP.txt
> > @@ -1,17 +1,19 @@
> > -RCU on Uniprocessor Systems
> > +.. _up_doc:
> 
> Certainly "up_rcu" seems like a better name.  I do believe, though, that
> you can also use the title directly:
> 
>   See `RCU on Uniprocessor Systems`_ for more information

That does look prettier, though we might want to do something more
directly mapped for people directly reading the .rst files.

> > >  - How can I see where RCU is currently used in the Linux kernel?
> > >  
> > > @@ -67,7 +67,7 @@ Frequently Asked Questions
> > >  
> > >  - Why the name "RCU"?
> > >  
> > > -  "RCU" stands for "read-copy update".  The file listRCU.txt has
> > > +  "RCU" stands for "read-copy update".  :ref:`list_rcu` has  
> > 
> > Same here for list_rcu.
> 
> And the problem is the same, it's list_rcu_doc in the actual source file.
> 
> Jiang, as with so many things in software, if you haven't tested it, it
> probably doesn't work.  Please actually run "make htmldocs" and look at
> the results to be sure that they are what you expect.  (Along those lines,
> it would also be good to add the new directory to Documentation/index.rst
> so that it gets built with the rest).

What Jon said on the "haven't test it, it probably doesn't work" thought.
Sometimes I fear that my own work could be all too accurately modeled as
random mutations with rcutorture providing needed natural selection.  :-/

							Thanx, Paul
