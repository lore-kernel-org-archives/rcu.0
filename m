Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D9EB64DA
	for <rcu@archiver.kernel.org>; Wed,  5 Jul 2023 12:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjGEMlL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 08:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGEMlL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 08:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD4116;
        Wed,  5 Jul 2023 05:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0129161503;
        Wed,  5 Jul 2023 12:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0202C433C8;
        Wed,  5 Jul 2023 12:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688560869;
        bh=Q7lihklVNA978w7esJOsxnmRuuyHw/4jy8/HtRgD23U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgPbK1R+lK3ukRLbUfyqgffhL5OKUT+r72u8axNjes6sIDlmKKm2yPVKP2jHv5PFM
         DhZMRnGTiEhynTpthgP+aOO5ltcgFqyhNP5gZ49L4A1LetkOxOxEZ7vDQooDLNGwJQ
         oqQp2oUBpFYw+plcqxAdQqQ3UuACagbMqHa9SeFaelxsfvhz8JuyUjB094wvyAjYke
         3npJw1S50ezR6vhdIxSmhuGXYVuQFuydfdjtbY5fIdLAqw5cREcMLvoAbgERooeoxQ
         3Ah16NmqPBtABEnxoC5oWHep8X0u6dPKZH6bWiGdJKBKiUVOJPnfw3n6wGwH/n2jyc
         MseidTfhd9Ksw==
Date:   Wed, 5 Jul 2023 14:41:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 0/9] rcu: Support for lazy callbacks on
 !CONFIG_RCU_NOCB_CPU
Message-ID: <ZKVk4jUtsPdfgjjJ@localhost.localdomain>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Wed, May 31, 2023 at 12:17:27PM +0200, Frederic Weisbecker a écrit :
> Hi,
> 
> Here is a first attempt at providing support for lazy callbacks on
> non-offloaded CPUs. I have measured interesting results on my machine
> when it is mostly idle (just an idle ssh connection kept alive) with
> a gain of +10% idle time. This needs more serious testing though,
> especially to make sure that no performance regression is introduced.

So after refining my measurements, it actually doesn't seem to bring
much.

Here's what I measured (it's an average after 100 runs):

* 0.01% more idle time during a "sleep 10"
* introduce 3% performance regression during an "scp" on the tools directory
  of the kernel source.
* Brings less than 1% performance improvement with a "make" on tools/perf

It only brings unconditional improvement when rcu boost is enabled (callbacks
offloaded to rcuc) but still below 1%.

The reason for the performance penalty is unclear, I initially thought it
was due to the batch execution delaying other softirqs vectors but it doesn't
look that way after all.

So for now I'm only going to re-iterate the cleanups in the beginning
of the patchset and I'll wait for a good reason before ever proceeding with the
rest.

Thanks.
