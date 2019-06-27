Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529BCC48BD6
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309FF2133F
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 16:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0Q1E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:27:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbfF0Q1E (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 27 Jun 2019 12:27:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RGIMap145608
        for <rcu@vger.kernel.org>; Thu, 27 Jun 2019 12:27:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2td0krtgf1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Thu, 27 Jun 2019 12:27:02 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Jun 2019 17:27:02 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Jun 2019 17:26:57 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5RGQu7r36045142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 16:26:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D1CDB206A;
        Thu, 27 Jun 2019 16:26:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FDACB205F;
        Thu, 27 Jun 2019 16:26:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jun 2019 16:26:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 58C6716C2BD7; Thu, 27 Jun 2019 09:26:58 -0700 (PDT)
Date:   Thu, 27 Jun 2019 09:26:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jiunn Chang <c0d1n61at3@gmail.com>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: [Linux-kernel-mentees][PATCH v5 1/5] Documentation: RCU: Convert
 RCU basic concepts to reST
Reply-To: paulmck@linux.ibm.com
References: <20190626191249.21135-1-c0d1n61at3@gmail.com>
 <20190626200705.24501-2-c0d1n61at3@gmail.com>
 <20190627083443.4f4918a7@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627083443.4f4918a7@lwn.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062716-0072-0000-0000-00000441C521
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011341; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01224073; UDB=6.00644229; IPR=6.01005262;
 MB=3.00027492; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-27 16:27:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062716-0073-0000-0000-00004CB1F2C5
Message-Id: <20190627162658.GV26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906270187
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 27, 2019 at 08:34:43AM -0600, Jonathan Corbet wrote:
> On Wed, 26 Jun 2019 15:07:01 -0500
> Jiunn Chang <c0d1n61at3@gmail.com> wrote:
> 
> > RCU basic concepts reST markup.
> > 
> > Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> So this is a little detail but ... your signoff should be the last thing
> in the set of tags on the patch.
> 
> This isn't worth making you do yet another revision, so I went ahead and
> applied the patches and fixed the tag ordering on the way in.  I'll also
> append a patch adding the new RCU stuff into the core-api manual so people
> can actually get to it.

Please feel free to add my ack:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

							Thanx, Paul

