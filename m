Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C098EC4332F
	for <rcu@archiver.kernel.org>; Tue, 13 Dec 2022 22:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiLMWFC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiLMWE4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Dec 2022 17:04:56 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35835C749;
        Tue, 13 Dec 2022 14:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ah/T9/v96bTXudUopkww7VGzdduYIsLnjDeq9t7RTG4=; b=HBlTiLkzOT3m3OqhIk+KCZuz4M
        HNPFk0cj83zBHMSxqgibAU9GEns4iv9A5BkXLFSNwTAdBffbqWbDiJy+EN9F923BPxfhWdvFzA9tu
        T9GPT4kQyjmOVNzzRLLIB8n1jpZHHT16xjIFFxhTAykqBofc+wanW+IaOLzb4AzzZL5ZHqEMN+cZa
        qffPIEC4Vlo2R3KbfiPnpAPH2Bf0gk4pG4qJyLDePMpk1EbNFH9wqJ1bVDOsUdaOhS16RG5hFxPbK
        8Sd7qMJctKYd/O9L5199ojEAbKrU6tVWr3dn6hgzgifWV9qWN0YkSdc9wdmJXgOKktVsjZH6s0Ww0
        EUd2pS7w==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5DOL-002nA3-CN; Tue, 13 Dec 2022 23:04:49 +0100
Message-ID: <07b8285c-abfc-dcc6-5a20-b6f8c9bc7e1e@igalia.com>
Date:   Tue, 13 Dec 2022 19:04:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Content-Language: en-US
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        rcu@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
 <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 16/11/2022 03:36, Masami Hiramatsu (Google) wrote:
> On Tue, 15 Nov 2022 17:48:47 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> The function match_records() may take a while due to a large
>> number of string comparisons, so when in PREEMPT_VOLUNTARY
>> kernels we could face RCU stalls due to that.
>>
>> Add a cond_resched() to prevent that.
>>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Acked-by: Paul E. McKenney <paulmck@kernel.org> # from RCU CPU stall warning perspective
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thanks!
> 

Hi Steve, sorry to annoy, just a regular ping to see if we can get this
into 6.2 (if too late, not a huge deal).

Thanks,


Guilherme
