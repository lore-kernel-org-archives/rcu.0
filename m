Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CBCC433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6720D225AA
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLIRtg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:49:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgLIRta (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 12:49:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09C7EAD0E;
        Wed,  9 Dec 2020 17:48:49 +0000 (UTC)
Subject: Re: [PATCH v2 sl-b 2/5] mm: Make mem_dump_obj() handle NULL and
 zero-sized pointers
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-2-paulmck@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <462f135a-f8e4-6291-6c1c-4fdd2e415462@suse.cz>
Date:   Wed, 9 Dec 2020 18:48:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209011303.32737-2-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 12/9/20 2:13 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit makes mem_dump_obj() call out NULL and zero-sized pointers
> specially instead of classifying them as non-paged memory.
> 
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <linux-mm@kvack.org>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/util.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index d0e60d2..8c2449f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -985,7 +985,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
>  void mem_dump_obj(void *object)
>  {
>  	if (!virt_addr_valid(object)) {
> -		pr_cont(" non-paged (local) memory.\n");
> +		if (object == NULL)
> +			pr_cont(" NULL pointer.\n");
> +		else if (object == ZERO_SIZE_PTR)
> +			pr_cont(" zero-size pointer.\n");
> +		else
> +			pr_cont(" non-paged (local) memory.\n");
>  		return;
>  	}
>  	if (kmem_valid_obj(object)) {
> 

