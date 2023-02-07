Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16661C05027
	for <rcu@archiver.kernel.org>; Tue,  7 Feb 2023 00:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBGA2n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 6 Feb 2023 19:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBGA2l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 6 Feb 2023 19:28:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3730B3C;
        Mon,  6 Feb 2023 16:28:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675729706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkA/VZLSMt+g+hF5PzyZwMAS/jFDr4vLGGGvaon2WXU=;
        b=Elth1YQry1e/wjfU2WKZy+a0IDzdif919Q+yp/AoHpg0ifzA9OftHxHecuwF3CEEZHA7jV
        A/XUgTDbtLtSuBdY8Ku/aBYdhZ9vfnb7MT3ICiMUsvsyJ3c9x4U+PN5qosg3wyg5FAvEnD
        yi4SwVgoc9L9oeNVsh/1dLhYJNkFbPpDjYtJKUTyTIDrB4Uz/pZrLd4dWwFXgckt3T2JUN
        XuF3BUmJ8oYMmrLQWY+FesIlVnNuaEa7wrW2h563vKXaIx4bw7ZhWgc9XzWYzDF1Fg9dLQ
        ld1hBLbAsewaz42czv5Zv6B3A+9oVu5+GX5uJiCR2VaBitKT7f9tVsGai0b9Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675729706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkA/VZLSMt+g+hF5PzyZwMAS/jFDr4vLGGGvaon2WXU=;
        b=iRfLS11evIO62CFcBkgJ6IRJiVROPve7Z6JWU7+WbqLmKLnhs/E3fc8qPmpz+aRVeyhfUB
        iFO5jJQNQJ6IyjDw==
To:     Usama Arif <usama.arif@bytedance.com>, dwmw2@infradead.org,
        arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [PATCH v6 08/11] x86/smpboot: Send INIT/SIPI/SIPI to secondary
 CPUs in parallel
In-Reply-To: <20230202215625.3248306-9-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
 <20230202215625.3248306-9-usama.arif@bytedance.com>
Date:   Tue, 07 Feb 2023 01:28:25 +0100
Message-ID: <87mt5qwc7q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 02 2023 at 21:56, Usama Arif wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
>
> When the APs can find their own APIC ID without assistance, we can do

We can do nothing ... Again, read Documentation/process ...

> the AP bringup in parallel.
>  /**
>   * arch_disable_smp_support() - disables SMP support for x86 at runtime
>   */
> @@ -1550,6 +1560,10 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>  		do_parallel_bringup = false;
>  	}
>  
> +	if (do_parallel_bringup)
> +		cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
> +					  native_cpu_kick, NULL);

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

Thanks,

        tglx
