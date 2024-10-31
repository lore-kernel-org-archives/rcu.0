Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F4881E;
	Thu, 31 Oct 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368586; cv=none; b=nizOuudZqmCFxkGw/MGqLJtx57/3gidvtMC+0CyIU5WyJTM3WX+oDbEQpXyI8PwYy8s2LMuf+GrMJsH5Fc7CuZEpfnedHAmGU+bWToKS9LpmCk9xZbiUDcBgHtOJzQTTvE8kcclE4s8gl+ygjvRmzcNZMkQSIvHYVRG+Znrjjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368586; c=relaxed/simple;
	bh=zKzNSTsm9kZsx8FTdXvTTYjRggtiZqQ7IKKtRbWzyUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB5zHSUIDQFfQh+whL1g510z9kqKJc35Q26RG3UAxsJi2TbIYRtDt677XjKWreWuMabD3UNNwihGj2Ugvn5+pTPvGVdStfe1SWXlOKIz+qdIuiSTO0tdgCiVht/FEkvaWlKKMLZPMrqzlmAU991RAYe92lJdVZyTOmO2p7BdXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXu3YziH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXu3YziH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00914C4CEC3;
	Thu, 31 Oct 2024 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730368586;
	bh=zKzNSTsm9kZsx8FTdXvTTYjRggtiZqQ7IKKtRbWzyUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXu3YziHhfNpjfKIXLX3ZQ/RQ0/85sbUzIQGjhnmYqKZ9gh6SMD2lY9MOawxNRCgB
	 hihTd5j5rGilUCeiWtV5s5cLiYSFCUY34CBxpaurAvy/dF0KFH5NLUVK7N+lRwh7a8
	 UlUXUYECecWkVhC8X732LX0p6Yar5JiEoUYcSQwCyIXMBd6j3qnNkz2QTfc3D2UdZN
	 l7JRGd/sUYg32GMlp9gqA2hyqHklc/xeF2Vi7ttGq4G6hQtotOcX0+gNQzTS1l60RQ
	 /abRnv4fkheiH9lgCWEYmBIz9f3QufRVrom5PfavZfwmiprXtsv8SB64wFx+hRnBWW
	 aZs/c3AFLJc2g==
Date: Thu, 31 Oct 2024 10:56:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	rcu <rcu@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: next-20241031: kernel/time/clockevents.c:455
 clockevents_register_device
Message-ID: <ZyNUR4oi8TXeEpYi@lothringen>
References: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtb5vAnEiHupwsnaeZ7uzdko_WAcjw9ZAFkHNXBVhi1EA@mail.gmail.com>

Hi,

On Thu, Oct 31, 2024 at 02:10:14PM +0530, Naresh Kamboju wrote:
> The QEMU-ARM64 boot has failed with the Linux next-20241031 tag.
> The boot log shows warnings at clockevents_register_device and followed
> by rcu_preempt detected stalls.
> 
> However, the system did not proceed far enough to reach the login prompt.
> The fvp-aemva, Qemu-arm64, Qemu-armv7 and Qemu-riscv64 boot failed.
> 
> Please find the incomplete boot log links below for your reference.
> The Qemu version is 9.0.2.
> 
> This is always reproducible.
> First seen on Linux next-20241031 tag.
>   Good: next-20241030
>   Good: next-20241031
> 
> qemu-arm64:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig
> 
> qemu-armv7:
>   boot:
>     * clang-19-lkftconfig
>     * gcc-13-lkftconfig
>     * clang-nightly-lkftconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Boot log:
> -------
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
>     0.000000] Linux version 6.12.0-rc5-next-20241031 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
> for Debian) 2.43.1) #1 SMP PREEMPT @1730356841
> [    0.000000] KASLR enabled
> [    0.000000] random: crng init done
> [    0.000000] Machine model: linux,dummy-virt
> <trim>
> <6>[    0.216503] GICv3: CPU1: found redistributor 1 region 0:0x00000000080c0000
> <6>[    0.218511] GICv3: CPU1: using allocated LPI pending table
> @0x0000000100250000
> <4>[    0.220528] ------------[ cut here ]------------
> <4>[ 0.220657] WARNING: CPU: 1 PID: 0 at kernel/time/clockevents.c:455
> clockevents_register_device (kernel/time/clockevents.c:455

It's possible that I messed up something with clockevents.

Can you try to reproduce with:

git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
	timers/core

And if so it's possible that the bad commit is somewhere between:

    17a8945f369c (clockevents: Improve clockevents_notify_released() comment)

and

    bf9a001fb8e4 (clocksource/drivers/timer-tegra: Remove clockevents shutdown call on offlining)

I wish I could reproduce on my own but I don't have easy
access to such hardware.

Thanks.
