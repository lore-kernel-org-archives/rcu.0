Return-Path: <SRS0=0EAO=S3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07558C43219
	for <rcu@archiver.kernel.org>; Thu, 25 Apr 2019 16:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F8E206BF
	for <rcu@archiver.kernel.org>; Thu, 25 Apr 2019 16:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V+6vReaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfDYQqB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:46:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39261 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDYQqB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Apr 2019 12:46:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id i17so188291pfo.6
        for <rcu@vger.kernel.org>; Thu, 25 Apr 2019 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhKHPT4snfwvoi+wqCTzmPy0v8C5sp/kHh3PEbQ+tE4=;
        b=V+6vReaT/QgAsg8enZlq0RvMJYbYnnsiox5sEcjMc+K7fePnDAhsSR5FwJUnP+odRs
         G0IKr4hhOmsNsw055LGGvN3qPmpQgH7zIX7H1iN88ERXOWyZO6NLulozVdz4RDkheju+
         7CUPzN/SF9UfIXGNi8JIRsvwEM55JRVNtANvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhKHPT4snfwvoi+wqCTzmPy0v8C5sp/kHh3PEbQ+tE4=;
        b=sxVmrAZUzsNSiJ7+RAgimIQJyfzq7oujXvAhEQkDt/Iq/9NzexRwNUFh2Yj4seTXaJ
         wyO2/TKZUC1loQekgxK3hZoS4W8kezVbpAHuecJNNhun4ZL/PyxVpNS6PLdLQhQGDh5t
         3BS5eOjFVX9yCTn7H6tb+S6kYx+Bd3dJqQ8hHmEtCTUO3LVjjU5DXi6evSPNN9WWLhnP
         klU+IAHSHgZaxZVWZS5Db1jEFPI+BaId57Q+jSx9foATkoCZJIhGXddliysukNs0B1ur
         4qFH+Zj+Ydd+e9qJWn84ic4zcLTipYEBLIldNS8xFZ35Y4aOIVusKniIDhj1ZSWaYpIM
         oilw==
X-Gm-Message-State: APjAAAVBhdAWXkcsjxnltBPc3MrMQANdzgGqSpikKn+f4nsdSZzgUL5n
        EKqx0TRizxNuRqnWshgBlYsHcnKdCU0=
X-Google-Smtp-Source: APXvYqywaghYIZIRbjwTxQpAZHHYxKur1K2T4xnrZ8XYW0Qf01+S+YtbhBCJVJ7soquXpgcX9mn5jw==
X-Received: by 2002:a65:4481:: with SMTP id l1mr37924422pgq.66.1556210760421;
        Thu, 25 Apr 2019 09:46:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v15sm31168891pff.105.2019.04.25.09.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 09:45:59 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:45:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Message-ID: <20190425164558.GA233442@google.com>
References: <20190424073446.8577-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424073446.8577-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 24, 2019 at 09:34:46AM +0200, Sebastian Andrzej Siewior wrote:
> In one of my rcutorture tests the TSC clocksource got marked unstable
> due to a large difference in the TSC value. I'm not sure if the guest
> run for a long time with disabled interrupts or if the host was very
> busy and didn't schedule the guest for some time.
> I took a look on the qemu/KVM options and decided to update the options:
> - Use kvm{32|64} as CPU. We could probably use `host' (like ARM does)
>   for maximum available features but since we don't run any userland I'm
>   not sure if it makes any difference.
> 
> - Drop the "noapic" option, enable TSC deadline timer. There is no
>   history why the APIC was disabled, I see no reason for it. The
>   deadline timer is probably "nicer".

I was wondering why the tsc deadline timer can't just be the default in the
kernel if it is "nicer" / "better" , and why does it need to be an option.

> 
> - Additional config options. It ensures that the kernel knowns that it
>   runs as a kvm guest and can use virt devices like the kvm-clock as
>   clocksource. The kvm-clock was the main motivation here.
> 
> - I didn't add a random HW device. It would make the random device ready
>   earlier (not it doesn't complete the initialisation at all) but I
>   doubt that there is any need for this.

Didn't follow this point about "random HW device". It looks like there is no
part of the patch that matches this comment. There was no "random HW device"
needed for this change of the clocksource, so could you clarify what this means?

Otherwise lgtm, thanks!

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

- Joel

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  tools/testing/selftests/rcutorture/bin/functions.sh | 13 ++++++++++++-
>  .../selftests/rcutorture/configs/rcu/CFcommon       |  4 ++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> index 6bcb8b5b2ff22..be3c5c73d7e79 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -172,7 +172,7 @@ identify_qemu_append () {
>  	local console=ttyS0
>  	case "$1" in
>  	qemu-system-x86_64|qemu-system-i386)
> -		echo noapic selinux=0 initcall_debug debug
> +		echo selinux=0 initcall_debug debug
>  		;;
>  	qemu-system-aarch64)
>  		console=ttyAMA0
> @@ -191,8 +191,19 @@ identify_qemu_append () {
>  # Output arguments for qemu arguments based on the TORTURE_QEMU_MAC
>  # and TORTURE_QEMU_INTERACTIVE environment variables.
>  identify_qemu_args () {
> +	local KVM_CPU=""
> +	case "$1" in
> +	qemu-system-x86_64)
> +		KVM_CPU=kvm64
> +		;;
> +	qemu-system-i386)
> +		KVM_CPU=kvm32
> +		;;
> +	esac
>  	case "$1" in
>  	qemu-system-x86_64|qemu-system-i386)
> +		echo -machine q35,accel=kvm
> +		echo -cpu ${KVM_CPU},x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on
>  		;;
>  	qemu-system-aarch64)
>  		echo -machine virt,gic-version=host -cpu host
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> index d2d2a86139db1..322d5d40443cd 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,2 +1,6 @@
>  CONFIG_RCU_TORTURE_TEST=y
>  CONFIG_PRINTK_TIME=y
> +CONFIG_HYPERVISOR_GUEST=y
> +CONFIG_PARAVIRT=y
> +CONFIG_PARAVIRT_SPINLOCKS=y
> +CONFIG_KVM_GUEST=y
> -- 
> 2.20.1
> 
