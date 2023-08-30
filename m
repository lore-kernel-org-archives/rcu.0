Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F0C6FA8F
	for <rcu@archiver.kernel.org>; Wed, 30 Aug 2023 18:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbjH3Srw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbjH3MIG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Aug 2023 08:08:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35861A1;
        Wed, 30 Aug 2023 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/gWxFPnB15/xfwVvJEhax18cVn+NYcCgEBxnuE+iV9g=; b=Hs41N30Kv8sSbfJi+YT0uWbRj5
        F11cs93nDxxSZLeXUJhh5W+KgL/ashc3+bTesuZuTvCOTj92JWV3CGQZPX4Nfbq3pcXlmse63pZQT
        jbKI9xAFE8xZO/Zm9SlaCxSgrFDgXbQ0UWbLhof3JiOzDLvJaB3wwPr/yOCizWVmJ/pvT2auXLVjJ
        cy9UUhu/MwQ63b/EVnmEFp7NpdSEpEImV6mz2Tra85/P+wmmFX4C1985DcQ0LBO9lNekpScz8cSsN
        tabnVcb2EGsxCgpB1gBruRBM5EKsDqF6q+Z1aVocbKRvcWiRgfUzE/Meab5ivwHto0jWqPc5ePWQH
        6x6+b0eA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbJzJ-00Cebn-Eb; Wed, 30 Aug 2023 12:07:57 +0000
Date:   Wed, 30 Aug 2023 13:07:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <ZO8xHT5HUDTSVUai@casper.infradead.org>
References: <20230830110402.386898-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830110402.386898-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 30, 2023 at 11:03:59AM +0000, Joel Fernandes (Google) wrote:
> It is unsafe to dump vmalloc area information when trying to do so from
> some contexts. Add a safer trylock version of the same function to do a
> best-effort VMA finding and use it from vmalloc_dump_obj().
> 
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: rcu@vger.kernel.org
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I once started writing something similar, but got distracted and the
immediate problem got solved a different way.

It does make me wonder if we couldn't make this tree RCU-safe, but
that's obviously a much larger job.
