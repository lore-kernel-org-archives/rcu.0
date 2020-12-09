Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BF6C433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2495323B98
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgLIIR7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgLIIR7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 03:17:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E10AC0613D6;
        Wed,  9 Dec 2020 00:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ZZ3HYGP9gEtqlYwfc7yhe+eaTjdZ3Qitzpf6acm63I=; b=TGWv0NdWksgoupC6WqJKXpu06T
        RwI0qSiUuqiegD0jOr418V6EZYUc2rbn9EUzh2tZ/3DfaCVDxsGUJRTXXVYz/XAWpqH45mDWxTmL1
        mz55IUCVUihCwlpj26HHv0hwJwfOokVpdPvX74f47nQECV+flSI3QCIrNnkkTeD/EvXEkCLXk9EOJ
        h629WJaxXnNhEvxrklkgYFmSkC/u2R+AV3Z50ttj63ZeAmadEhQa2OvcdFF/ewhdxwT+Qj3bU16f/
        QC5+ini7XPVgdK/XH05EhDqyfdHBJlnfSIBLlrLyMU2Hlc9qqlpIV4HfxUhKtCs0v3+DMq4yFvQn1
        5W63QpWQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmues-0004hl-TC; Wed, 09 Dec 2020 08:17:11 +0000
Date:   Wed, 9 Dec 2020 08:17:10 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201209081710.GA17642@infradead.org>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209011303.32737-1-paulmck@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Your two new exports don't actually seem to get used in modular code
at all in this series.
