Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D9C433F5
	for <rcu@archiver.kernel.org>; Wed, 20 Oct 2021 00:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E9461029
	for <rcu@archiver.kernel.org>; Wed, 20 Oct 2021 00:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJTAEb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Oct 2021 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJTAEa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Oct 2021 20:04:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036EC06161C;
        Tue, 19 Oct 2021 17:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uPrY0ypRsE15LW5b7tLqoRLW570zfp/AOUFWuuQ1aoM=; b=oSjhZCVPGCsT4cWX9cJ/vvCTwN
        VN+YjKo5cd8hNWPFa8UxXoHGDvebhfrNcJWqXVNrMpPrNz1u+h7FzZFd3vSHDgfNx1+QHmnqb2/+0
        N4TXmAAbwZzVCX8qouhILc5XGwkHJmJk+dpRmDQarN6ZrsbbdWa8uG2iCYubNJ5EPXLX+TNCl5/IK
        lwECglqzHSTfnDFX0p55fBkOd0II1Z0/4SY8IxY+uU2ZAAGr3vY+bMAFNcR2gXfRxbHtOL0+Q3mtF
        mGde1mZq9bcMmqSR4owTY7NnqiJCHgfxj9UaBeOycZTOlhiMVZl/BgP77r+Bbs2ULB+JGvDLXCYMv
        SHv06IxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcz23-00C6ci-Hd; Wed, 20 Oct 2021 00:00:53 +0000
Date:   Wed, 20 Oct 2021 01:00:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add refcount analogy to What is RCU
Message-ID: <YW9cI5HY01WPBN4h@casper.infradead.org>
References: <163468470814.17149.17892190693057737430@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163468470814.17149.17892190693057737430@noble.neil.brown.name>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 20, 2021 at 10:05:08AM +1100, NeilBrown wrote:
>  
> -.. _8_whatisRCU:
> +.. _9_whatisRCU:
>  
> -8.  ANSWERS TO QUICK QUIZZES
> +9.  ANSWERS TO QUICK QUIZZES
>  ----------------------------

I think you have some other references to fixup.

$ git grep 8_whatisRCU
Documentation/RCU/whatisRCU.rst::ref:`8.        ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
Documentation/RCU/whatisRCU.rst::ref:`Answers to Quick Quiz <8_whatisRCU>`
Documentation/RCU/whatisRCU.rst::ref:`Answers to Quick Quiz <8_whatisRCU>`
Documentation/RCU/whatisRCU.rst::ref:`Answers to Quick Quiz <8_whatisRCU>`
Documentation/RCU/whatisRCU.rst:.. _8_whatisRCU:

Maybe the label should be whatisRCU_answers instead of 8_whatisRCU ?
