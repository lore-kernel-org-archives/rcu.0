Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5216EC48BD6
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB72084B
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 21:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFYVqM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:46:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725782AbfFYVqL (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Jun 2019 17:46:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PLgSsd032374;
        Tue, 25 Jun 2019 17:45:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbry4pnh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 17:45:31 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5PLhEgS035657;
        Tue, 25 Jun 2019 17:45:31 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbry4pngu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 17:45:31 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5PLisVk013916;
        Tue, 25 Jun 2019 21:45:30 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2t9by72uk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 21:45:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PLjTYI51446022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 21:45:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44701B2066;
        Tue, 25 Jun 2019 21:45:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30CF7B206A;
        Tue, 25 Jun 2019 21:45:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 21:45:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A382816C5D8C; Tue, 25 Jun 2019 14:45:29 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:45:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v3 5/6] Documentation: RCU: Add
 links to rcu.rst
Message-ID: <20190625214529.GS26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
 <20190625062627.26378-6-c0d1n61at3@gmail.com>
 <20190625155623.GA26519@linux.ibm.com>
 <20190625150155.5c9b8880@lwn.net>
 <20190625211740.GQ26519@linux.ibm.com>
 <20190625154010.557448ff@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625154010.557448ff@lwn.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250168
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 25, 2019 at 03:40:10PM -0600, Jonathan Corbet wrote:
> On Tue, 25 Jun 2019 14:17:40 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> 
> > > Certainly "up_rcu" seems like a better name.  I do believe, though, that
> > > you can also use the title directly:
> > > 
> > >   See `RCU on Uniprocessor Systems`_ for more information  
> > 
> > That does look prettier, though we might want to do something more
> > directly mapped for people directly reading the .rst files.
> 
> Yeah, the alternative there is to just say "Documentation/RCU/UP.rst".
> It's vaporware at the moment, but the plan is to recognize such strings
> and link them up automatically in the build process.  It's easy enough to
> do, I just have to get around to it.  In anticipation of that, just
> putting in the file name is probably the right thing to do.

Works for me!  Easy enough to cut-and-paste the filename into the
corresponding portion of the URL, in the meantime.

							Thanx, Paul
