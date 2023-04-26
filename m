Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F24C7EE25
	for <rcu@archiver.kernel.org>; Wed, 26 Apr 2023 14:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjDZOV5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbjDZOVy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Apr 2023 10:21:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4536E90;
        Wed, 26 Apr 2023 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UlGyOC+dZ9jM8uq2AbAYjxW/eRqy+SHHT/cj9czdtZA=; b=mYHgtFZffSP0zSxghYAqv/xYil
        LbxNzzdoBpuTahkiYD8MdM4WlZdvMxu5vz/B5ySvJTBOEVKtQQXTPQ4rM9uZdqv/7TVV8MtHUIxkd
        ZSM+w9gBfEGEkfZE5Jg21u6dO+S+kMJBhe84FuKb0XX5YrL9x4/4fDa84nt6MiaRsm6Xj6vMRD6G5
        Ilkh9WXFY8ZdF884WAH4JxOUayYPGI4S5K5NVjsEGEJWn0p/QYRyCe+dwg9P5KzISeKYtnfrk/9Gh
        cn1p5ejTDigTEQvM9YJtQc57z8baLO9YaSnUPfH/MqNX8eRVRaCcs3Z4t7sOss8mMFpzvPioxRenR
        UmgQ7hIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prg0v-002Xdk-RA; Wed, 26 Apr 2023 14:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABE86300244;
        Wed, 26 Apr 2023 16:20:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 828103240EFBA; Wed, 26 Apr 2023 16:20:54 +0200 (CEST)
Date:   Wed, 26 Apr 2023 16:20:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <20230426142054.GA1381951@hirez.programming.kicks-ass.net>
References: <ZEXOMC2casTlobE1@boqun-archlinux>
 <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
 <877ctyzv08.fsf@mail.concordia>
 <CAEXW_YR4rmNY5JF-077EUpriF=PP9uML+_WMDSVi-L3G6_FOdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR4rmNY5JF-077EUpriF=PP9uML+_WMDSVi-L3G6_FOdw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 26, 2023 at 09:44:22AM -0400, Joel Fernandes wrote:

> How could you control which code paths don't have the stack protector?
> Just curious.

https://lkml.kernel.org/r/20230412-no_stackp-v2-0-116f9fe4bbe7@google.com
