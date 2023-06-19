Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FEEB64D9
	for <rcu@archiver.kernel.org>; Mon, 19 Jun 2023 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFSUkX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFSUkW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Jun 2023 16:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABC2DF
        for <rcu@vger.kernel.org>; Mon, 19 Jun 2023 13:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BA660EFC
        for <rcu@vger.kernel.org>; Mon, 19 Jun 2023 20:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 037DCC433C8;
        Mon, 19 Jun 2023 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687207221;
        bh=P9VJOkKQ5H2vYWV+M2nWdtZpaQBLBa1WEG34I7CVKio=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FyBrtr/iyCtKuxzJFrvyWFbO+w3S5fhStwHjdxzaNz+KA6lp1QNXvGHvc1aWZ/E/0
         vNE8zTG3BO71tVpmhxc8NpDbLif4tJwWCx4ngPbBxxwvtKNIZ7q52Cm8fY+Z2h6f34
         XgXPCPn0lCobnl1cjZh/CKWQHThMO4wtnTpViCrPQROaDgwkhwNvIzL3zj9jjs45zz
         0/NadvOxRQhaaWRvS+HE7RHXH06ob6omGEXj/+m2cfxRhPSez/rqRQO9LPzCig0cLM
         qbtA7z9Cd30gKA5s5Jt2mixpk7le30OFdnN/bC/LNxsnctZT9JnQY7KLeRILJwHgLe
         a3ShUA92DOhDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D71F0E301F8;
        Mon, 19 Jun 2023 20:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/5] Add benchmark for bpf memory allocator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168720722086.28519.12176432068427562571.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Jun 2023 20:40:20 +0000
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
In-Reply-To: <20230613080921.1623219-1-houtao@huaweicloud.com>
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 13 Jun 2023 16:09:16 +0800 you wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> This patchset includes some trivial fixes for benchmark framework and
> a new benchmark for bpf memory allocator originated from handle-reuse
> patchset. Because htab-mem benchmark depends the fixes, so I post these
> patches together.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/5] selftests/bpf: Use producer_cnt to allocate local counter array
    https://git.kernel.org/bpf/bpf-next/c/8ad663d3dfac
  - [bpf-next,v6,2/5] selftests/bpf: Output the correct error code for pthread APIs
    https://git.kernel.org/bpf/bpf-next/c/ea400d13fc92
  - [bpf-next,v6,3/5] selftests/bpf: Ensure that next_cpu() returns a valid CPU number
    https://git.kernel.org/bpf/bpf-next/c/da77ae2b27ec
  - [bpf-next,v6,4/5] selftests/bpf: Set the default value of consumer_cnt as 0
    https://git.kernel.org/bpf/bpf-next/c/970308a7b544
  - [bpf-next,v6,5/5] selftests/bpf: Add benchmark for bpf memory allocator
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


