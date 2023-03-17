Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374FEC74A5B
	for <rcu@archiver.kernel.org>; Fri, 17 Mar 2023 14:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCQOKB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Mar 2023 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCQOJw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Mar 2023 10:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E1EC76
        for <rcu@vger.kernel.org>; Fri, 17 Mar 2023 07:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1EFCB8245F
        for <rcu@vger.kernel.org>; Fri, 17 Mar 2023 14:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B328C4339B;
        Fri, 17 Mar 2023 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679062187;
        bh=sNaOqP2GjXyiaEUok6XslEVMRpjKMtgk1fUfSpvQdas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=an/oI8wJ6c822w+JuHY0vLFbMBtiH1bf4JOPBLgDpd2sqLc/xQN3ZJwRJFzcTXRXM
         72Uw30mKVhyD9sp3oIWcPhylM5wzdF4BU3srw+iv3aVHQB6mHfFGDDUQGucKWi6otA
         MaQ2FyhOjZBwxMA5kai75iNtGPMn5JeRVazY7+YVBwdRub7T4cjGCnkHuxjyBnN/C/
         98O+tvUJtjNFGAIs0eF96lCPeWUPAJ7JIPg5EnsCsWzkJVP3vIinPAUUD5/Pm/y6Uw
         eB3pIgOIDAbkEYqx+n5wtyCswNH8cmn9zj5c2GOwMb7hOiO9ZrrBvzbYWfLOjCUHH8
         +E/jOErOXRN7Q==
Date:   Fri, 17 Mar 2023 15:09:44 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     boqun.feng@gmail.com, quic_neeraju@quicinc.com, paulmck@kernel.org,
        heng.su@intel.com, lkp@intel.com, peterz@infradead.org,
        rcu@vger.kernel.org
Subject: Re: [Syzkaller & bisect] There is "sys_perf_event_open" soft lockup
 BUG in v6.3-rc2 kernel
Message-ID: <ZBR0qFQYoq4+2sXC@lothringen>
References: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBQbUUX+cBlMckCz@xpf.sh.intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 17, 2023 at 03:48:33PM +0800, Pengfei Xu wrote:
> Hi Frederic Weisbecker and kernel experts,
> 
> Platform: x86 platforms
> There is "sys_perf_event_open" soft lockup BUG in v6.3-rc2 kernel in guest.

I can reproduce with you tests which is based on v6.2-rc5. However when
I forward port your .config to a v6.3-rc2, the issue doesn't trigger anymore.

Did you manage to reproduce on v6.3-rc2? And if so do you still have the related
.config ?

Thanks.
