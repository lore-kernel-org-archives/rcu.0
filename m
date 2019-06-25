Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379EFC48BD4
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 15:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CF8208CA
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 15:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfFYP4a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:56:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731382AbfFYP4a (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 25 Jun 2019 11:56:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PFqEns146554
        for <rcu@vger.kernel.org>; Tue, 25 Jun 2019 11:56:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbnm83cw6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Tue, 25 Jun 2019 11:56:28 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 25 Jun 2019 16:56:28 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 16:56:24 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5PFuNe538797742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 15:56:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35BFAB2067;
        Tue, 25 Jun 2019 15:56:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17DF7B2066;
        Tue, 25 Jun 2019 15:56:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 15:56:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 323F916C1085; Tue, 25 Jun 2019 08:56:23 -0700 (PDT)
Date:   Tue, 25 Jun 2019 08:56:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net
Subject: Re: [Linux-kernel-mentees][PATCH v3 5/6] Documentation: RCU: Add
 links to rcu.rst
Reply-To: paulmck@linux.ibm.com
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
 <20190625062627.26378-6-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625062627.26378-6-c0d1n61at3@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062515-0072-0000-0000-00000440D847
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011328; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223121; UDB=6.00643647; IPR=6.01004293;
 MB=3.00027464; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-25 15:56:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062515-0073-0000-0000-00004CB0FD78
Message-Id: <20190625155623.GA26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250120
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 25, 2019 at 01:26:26AM -0500, Jiunn Chang wrote:
> Add the following links:
>   - list_rcu
>   - up_rcu
> 
> Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
> ---
>  Documentation/RCU/rcu.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> index 000da07d683e..d145decb5c39 100644
> --- a/Documentation/RCU/rcu.rst
> +++ b/Documentation/RCU/rcu.rst
> @@ -10,8 +10,8 @@ A "grace period" must elapse between the two parts, and this grace period
>  must be long enough that any readers accessing the item being deleted have
>  since dropped their references.  For example, an RCU-protected deletion
>  from a linked list would first remove the item from the list, wait for
> -a grace period to elapse, then free the element.  See the listRCU.txt
> -file for more information on using RCU with linked lists.
> +a grace period to elapse, then free the element.  See :ref:`list_rcu`
> +for more information on using RCU with linked lists.
>  
>  Frequently Asked Questions
>  --------------------------
> @@ -49,7 +49,7 @@ Frequently Asked Questions
>  - If I am running on a uniprocessor kernel, which can only do one
>    thing at a time, why should I wait for a grace period?
>  
> -  See the UP.txt file in this directory.
> +  See :ref:`up_rcu` for more information.

This rendered as straight text after "make htmldocs" instead of producing
a link in the HTML output.  The HTML itself is:

	<span class="xref std std-ref">up_rcu</span>

This doesn't look like something that would create a link, though I
freely admit that my HTML is rather outdated.

>  - How can I see where RCU is currently used in the Linux kernel?
>  
> @@ -67,7 +67,7 @@ Frequently Asked Questions
>  
>  - Why the name "RCU"?
>  
> -  "RCU" stands for "read-copy update".  The file listRCU.txt has
> +  "RCU" stands for "read-copy update".  :ref:`list_rcu` has

Same here for list_rcu.

							Thanx, Paul

>    more information on where this name came from, search for
>    "read-copy update" to find it.
>  
> -- 
> 2.22.0
> 

