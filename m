Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC852C4707A
	for <rcu@archiver.kernel.org>; Sun, 23 May 2021 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29D3610A2
	for <rcu@archiver.kernel.org>; Sun, 23 May 2021 09:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhEWJmx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 23 May 2021 05:42:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhEWJmx (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 23 May 2021 05:42:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14N9Xv5J148295;
        Sun, 23 May 2021 05:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ociFyizVsM28GJMvNG8DMaVsQoWuT8RJpNowjEhIi/A=;
 b=K4dL4tad0pExKFz47Pi+fXjgDsK+xN+KiMKNKZYQWhG9zSr6NX7weICFKnsFj+kaYt3L
 cjHzQNqOLPBh4O5YalR0aEGcYPBsQ2+KNPLZCrkNoKCVqQSnA8hLNO+/VSxLj/xGqsYl
 JJ0stIYgIr5tbyBB4Y7RhF+PbEGBQXrQ7gUXd+QU7aslg2tCTyqOEi3oOpil0DhnmLch
 NYFxHZYHrbAHloOQarB104S5iBPlJ32O65w4DgL/Xy1S7HXuoWBMeIV4iZEMITaLeoOe
 /IvC50J8+V8BcsPNljCGDyZXLS60N3yUhuBOWXyEFOZ+LDo8yQq5FaJ92JUjdo6+ORIK 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38qjjdt1vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 May 2021 05:40:50 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14N9XtbO148186;
        Sun, 23 May 2021 05:40:50 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38qjjdt1vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 May 2021 05:40:49 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14N9RHK1014616;
        Sun, 23 May 2021 09:40:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 38psk886e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 May 2021 09:40:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14N9eG5M27394388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 May 2021 09:40:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3049AA405B;
        Sun, 23 May 2021 09:40:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8820AA4054;
        Sun, 23 May 2021 09:40:44 +0000 (GMT)
Received: from [9.145.68.41] (unknown [9.145.68.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 May 2021 09:40:44 +0000 (GMT)
Subject: Re: [PATCH] rculist: unify documentation about missing
 list_empty_rcu()
To:     paulmck@kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210521100829.257385-1-jwi@linux.ibm.com>
 <20210521175652.GC4441@paulmck-ThinkPad-P17-Gen-1>
From:   Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <65f39db3-41ec-dc7a-0600-082439735556@linux.ibm.com>
Date:   Sun, 23 May 2021 12:40:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210521175652.GC4441@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PJbQW_UKfbcYwrwzdjm9YwtFxDsoDmjv
X-Proofpoint-ORIG-GUID: K0wzkeLPKojKPCB2E9q8h2zUiuIwmpm-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-22_08:2021-05-20,2021-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105230070
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 21.05.21 20:56, Paul E. McKenney wrote:
> On Fri, May 21, 2021 at 12:08:29PM +0200, Julian Wiedmann wrote:
>> We have two separate sections that talk about why list_empty_rcu()
>> is not needed, consolidate them.
>>
>> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
> 
> Good catch, thank you!  As usual, I could not resist the urge to further
> wordsmith, resulting in the following.  Please let me know if I messed
> anything up.
> 
> 							Thanx, Paul
> 

I expected no different ;). LGTM, and clearly emphasizing that one shall
not mix list_empty() with list_first_entry_rcu() is a nice improvement.


> ------------------------------------------------------------------------
> 
> commit 6e9da58a4b391035e1ce77b8d867cdcdc73521b2
> Author: Julian Wiedmann <jwi@linux.ibm.com>
> Date:   Fri May 21 12:08:29 2021 +0200
> 
>     rculist: Unify documentation about missing list_empty_rcu()
>     
>     We have two separate sections that talk about why list_empty_rcu()
>     is not needed, so this commit consolidates them.
>     
>     Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
>     [ paulmck: The usual wordsmithing. ]
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index f8633d37e358..d29740be4833 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -10,15 +10,6 @@
>  #include <linux/list.h>
>  #include <linux/rcupdate.h>
>  
> -/*
> - * Why is there no list_empty_rcu()?  Because list_empty() serves this
> - * purpose.  The list_empty() function fetches the RCU-protected pointer
> - * and compares it to the address of the list head, but neither dereferences
> - * this pointer itself nor provides this pointer to the caller.  Therefore,
> - * it is not necessary to use rcu_dereference(), so that list_empty() can
> - * be used anywhere you would want to use a list_empty_rcu().
> - */
> -
>  /*
>   * INIT_LIST_HEAD_RCU - Initialize a list_head visible to RCU readers
>   * @list: list to be initialized
> @@ -318,21 +309,29 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>  /*
>   * Where are list_empty_rcu() and list_first_entry_rcu()?
>   *
> - * Implementing those functions following their counterparts list_empty() and
> - * list_first_entry() is not advisable because they lead to subtle race
> - * conditions as the following snippet shows:
> + * They do not exist because they would lead to subtle race conditions:
>   *
>   * if (!list_empty_rcu(mylist)) {
>   *	struct foo *bar = list_first_entry_rcu(mylist, struct foo, list_member);
>   *	do_something(bar);
>   * }
>   *
> - * The list may not be empty when list_empty_rcu checks it, but it may be when
> - * list_first_entry_rcu rereads the ->next pointer.
> - *
> - * Rereading the ->next pointer is not a problem for list_empty() and
> - * list_first_entry() because they would be protected by a lock that blocks
> - * writers.
> + * The list might be non-empty when list_empty_rcu() checks it, but it
> + * might have become empty by the time that list_first_entry_rcu() rereads
> + * the ->next pointer, which would result in a SEGV.
> + *
> + * When not using RCU, it is OK for list_first_entry() to re-read that
> + * pointer because both functions should be protected by some lock that
> + * blocks writers.
> + *
> + * When using RCU, list_empty() uses READ_ONCE() to fetch the
> + * RCU-protected ->next pointer and then compares it to the address of the
> + * list head.  However, it neither dereferences this pointer nor provides
> + * this pointer to its caller.  Thus, READ_ONCE() suffices (that is,
> + * rcu_dereference() is not needed), which means that list_empty() can be
> + * used anywhere you would want to use list_empty_rcu().  Just don't
> + * expect anything useful to happen if you do a subsequent lockless
> + * call to list_first_entry_rcu()!!!
>   *
>   * See list_first_or_null_rcu for an alternative.
>   */
> 

