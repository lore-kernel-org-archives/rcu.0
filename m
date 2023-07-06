Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06699EB64DD
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 01:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGFBuY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjGFBuY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 21:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF86819BE
        for <rcu@vger.kernel.org>; Wed,  5 Jul 2023 18:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B74D617D7
        for <rcu@vger.kernel.org>; Thu,  6 Jul 2023 01:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BB2C433C8;
        Thu,  6 Jul 2023 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688608220;
        bh=e0deVLmnjR7DOSBT7d3lP+S5ctjsbNgaMmvAvskRevE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=epZR3oA6Wvr24xBiRdZWg5S2ir0aiBjdPRqPVoI2QQLkTbLjQu8wRrKKEzJVWgMu2
         5jyC9W8gUu6OrUQaRFIF76vIIDq3okWDD/GivMzT2aGJIh5Nh25kMECRl05Jmlow4/
         fZXMUXd0a5Y8qwxNlpoar9x3AYmGZJ7gTpsoBZEPgcNahv98XNhfetDibF+YEKjfmg
         7pDi14+fj4My00T/yzw9eCP2OFXmcn9AkY7niVzJHADaWEoL/pAP2sAs1Z5K7lZV7p
         m3QqwvzQYFX8j3jrZ35fFBOSXcbcCIl6EzJmoIcii6fbiJBhvZ6Tey5gUDh071VmkI
         I4q62WUWGCVUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 867D0C40C5E;
        Thu,  6 Jul 2023 01:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9] selftests/bpf: Add benchmark for bpf memory
 allocator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168860822054.22142.13852026022704379153.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 01:50:20 +0000
References: <20230704025039.938914-1-houtao@huaweicloud.com>
In-Reply-To: <20230704025039.938914-1-houtao@huaweicloud.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev,
        alexei.starovoitov@gmail.com, andrii@kernel.org, song@kernel.org,
        haoluo@google.com, yhs@fb.com, daniel@iogearbox.net,
        kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, paulmck@kernel.org, rcu@vger.kernel.org,
        houtao1@huawei.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  4 Jul 2023 10:50:39 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The benchmark could be used to compare the performance of hash map
> operations and the memory usage between different flavors of bpf memory
> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
> could be used to check the performance improvement or the memory saving
> provided by optimization.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9] selftests/bpf: Add benchmark for bpf memory allocator
    https://git.kernel.org/bpf/bpf-next/c/fd283ab196a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


