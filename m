Return-Path: <SRS0=jERE=5T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F76AC43331
	for <rcu@archiver.kernel.org>; Fri,  3 Apr 2020 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3E620737
	for <rcu@archiver.kernel.org>; Fri,  3 Apr 2020 18:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ekPQvnbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404320AbgDCSQ5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:16:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404179AbgDCSQ4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Apr 2020 14:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xqf9ldErwZipwjo+fl+eRLkju/QhT7uG+RO6CX07x18=; b=ekPQvnbPY7L+eQb/daLRoe0jc6
        6U1Q8XG+26v6NeVbrGQTQP/8ME9htTQkw/MghIvemX1Yt/iCJap4R/s7vO6/UAOHurgtgLqtPc1f5
        +6jaHJYcyPyrkvAcbHamlUa4BzkkBeyBjH3eqxRtC14p61ZEVZjnWZWbXqOW06tCxDPIpjAV2l/gN
        D346Q7MzPGJkpZqpX2l7zMFp1au3wa8tmBjRhBhBSnRfDhwU6ux+IyPbeLv2/t9zm0XHYnqOH8qRV
        xhw2VGKuTdqjGi4Xsg3cOlL7FfVKejr0TzkUWdLZY+fQMs2V+YXnI6UqK8YHXSzeXa2FTT9joH8KS
        ok/l668w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKQsB-0006kJ-Af; Fri, 03 Apr 2020 18:16:55 +0000
Date:   Fri, 3 Apr 2020 11:16:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: add emergency pool for headless case
Message-ID: <20200403181655.GR21484@bombadil.infradead.org>
References: <20200403173051.4081-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403173051.4081-1-urezki@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 03, 2020 at 07:30:51PM +0200, Uladzislau Rezki (Sony) wrote:
> @@ -2877,6 +2885,12 @@ struct kfree_rcu_cpu {
>  	bool initialized;
>  	// Number of objects for which GP not started
>  	int count;
> +
> +	/*
> +	 * Reserved emergency pool for headless variant.
> +	 */
> +	int nr_emergency;
> +	void **emergency;

This is a pretty expensive way to maintain an emergency pool.

Try something like this ...

struct emergency_pool_object {
	union {
		struct whatever foo;
		struct {
			int remaining;
			void *next;
		};
	};
};

struct kfree_rcu_cpu {
	...
	struct emergency_pool_object *epo;
};

struct whatever *get_emergency_object(struct kfree_rcu_cpu *krc)
{
	struct emergency_pool_object *epo = krc->epo;
	if (epo)
		krc->epo = epo->next;
	return &epo->foo;
}

void alloc_emergency_objects(struct kfree_rcu_cpu *krc, int n)
{
	int i = 0;

	if (krc->epo)
		i = krc->epo->remaining;

	while (++i < n) {
		struct emergency_pool_object *epo = kmalloc(sizeof(epo), GFP);
		epo->remaining = i;
		epo->next = krc->epo;
		krc->epo = epo;
	}
}

