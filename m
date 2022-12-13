Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790E5C4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 23:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiLMXmN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 18:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLMXmL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 18:42:11 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE2FCD6;
        Tue, 13 Dec 2022 15:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h2p2PoHtqIvlac6HtD7H9ApdCHJGMv8yFtRiXiNACtA=; b=SzgLqwsneFN4VC7fomFswqCyFR
        o1RG4pKf6U+rXZeOAp/bYgs22U/NgyrvC6p0n64lr9hgsaGByi+LJ+tjJNXTluxaArRHDJhhIaMdE
        OIJpAB1v8nEdKbGVX1kKYVm4v9FdVVQu+SYpkM6A/IHjzJjj8HwsZpYP1MQibtLYMEE+H1xrBdvX4
        7MgwvTyANU7lTrrN13KopK2wZZvE47s5biTWrjyi1MlvL5bD5QZMb8wfK1kgk68MYtk1BFl4J4fMj
        r9HVfi546U46oJAaVhPJ/91gU5qrN/42f0wgoGYs7xVGU6ROiSyGRD0ndmyp7VYRRhfN1iKksnIaW
        GNxO+qGA==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5EuT-002qlf-QD; Wed, 14 Dec 2022 00:42:06 +0100
Message-ID: <49ccbce5-d2f9-c09f-b0b0-c4ba467f4a0c@igalia.com>
Date:   Tue, 13 Dec 2022 20:41:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        rcu@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
 <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
 <07b8285c-abfc-dcc6-5a20-b6f8c9bc7e1e@igalia.com>
 <20221213173425.609618fb@gandalf.local.home>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221213173425.609618fb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 13/12/2022 19:34, Steven Rostedt wrote:
> On Tue, 13 Dec 2022 19:04:41 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> Hi Steve, sorry to annoy, just a regular ping to see if we can get this
>> into 6.2 (if too late, not a huge deal).
> 
> Thanks for the ping. For some reason this patch didn't make it into my
> internal Patchwork, so I missed it (even though I did reply to you, I just
> assumed it was in my patchwork).
> 
> It's not too late. I have some last minute patches I'm still testing. I'll
> queue this one up.
> 
> BTW, we now have a kernel ftrace mailing list that you can Cc (but still Cc
> LKML). 
> 
>   linux-trace-kernel@vger.kernel.org
> 
> -- Steve

Tnx a lot Steve! I'll start to CC this list as well.

Cheers,


Guilherme
