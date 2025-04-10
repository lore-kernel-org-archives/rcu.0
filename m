Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253828A41F
	for <rcu@vger.kernel.org>; Thu, 10 Apr 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295495; cv=none; b=CO4bxR729lmiCrowJYYAqEw3uyquZtOcI8Vkp6Tk7d6RDKAaJeuDEizIbo7Vng8wfAOxADeYy8c56xLZIOk60WrrDSTB6M4xIKdPFA/LHtR4UwvUrmBkH/dAUZKXmgayC5g4WBZRHO3u+HITMYN84ORBW366GSSX81V6+B7Ep5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295495; c=relaxed/simple;
	bh=n5gcMiGV0b1+UB1prB+5rLg54z7KM/bi857LLCOk4II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY2sfeIh3P8TLR8dXPWcfgOlFwn+NUEp/98zx8fiikWNyBvg9npHQXhe4eY9g2w2aAVgBJoM6mSm2e6ZpIBh5a+v3oMw+tnbo5EXP+5OM0wq/BdulPChgddXsBPk3f2jhpF+BHs89d8NK2l8Evq+wB9d64nyK+zlZiuNnk+QzsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCGbT82o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCGbT82o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DB0C4CEDD;
	Thu, 10 Apr 2025 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744295495;
	bh=n5gcMiGV0b1+UB1prB+5rLg54z7KM/bi857LLCOk4II=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kCGbT82o9vxYRCyElhFPMDg3L2/psp5iD1zrAafXAIwXwUEMg7gGcN+WjJbvbD70S
	 AxKBazI2LFpyfjduSZ4w01pjbJFwFhUbU57BZfDu4mp+GaoH9Gjyh+S8BlCOY7Y0QX
	 0N2FraKjo4FF1bJ4yumvZmXpkAMS/w0/BQVPIGrA3qhSSVga6gQ+ibdBCClBR0dABR
	 EZP+2wGI1+njJwsJxfhBGSe6d8xjGJXOeOoAlFWPtB3p/LKgyC5P8zzhKyHsCDR4su
	 bUXw3gpUQ3/RCgqUfdTO5hKOe9lzAz7BiR8og1RR8niX+i45u5ZY5XKJmShwGocNjL
	 joKb9i3bgrVPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C1545CE087D; Thu, 10 Apr 2025 07:31:34 -0700 (PDT)
Date: Thu, 10 Apr 2025 07:31:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>
Subject: Re: Possible scriping bug in rcutorture/kvm.sh
Message-ID: <6c3c4861-a7ca-41d8-b9b5-0dfb226f54d0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a6039f75-3662-48cd-8346-4cb8ac929685@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6039f75-3662-48cd-8346-4cb8ac929685@nvidia.com>

On Thu, Apr 10, 2025 at 09:59:07AM -0400, Joel Fernandes wrote:
> Hello,
> Currently with my ARM machine of 288 CPUs, I am only seeing 56 of them used at a
> time. Any ideas if this is a bug or I am doing something wrong?

I regularly run with 80 CPUs, but perhaps the script's check for the
number of CPUs is broken on ARM?  It currently relies on this:

	getconf _NPROCESSORS_ONLN

(See identify_qemu_vcpus() in functions.sh.)

What should it be doing instead on ARM?

Huh.  56 does not go evenly into 288, either.  Search me!

							Thanx, Paul

> I started a batch of 36 SRCU-P runs, which is exactly 1 batch:
> 
> $ sudo tools/testing/selftests/rcutorture/bin/kvm.sh --duration 120 --allcpus
> --configs "10*SRCU-P" --dryrun batches
> 1 SRCU-P 8
> 
> 
> 1 SRCU-P.2 8
> 
> 1 SRCU-P.3 8
> 
> 1 SRCU-P.4 8
> 
> 1 SRCU-P.5 8
> 
> 1 SRCU-P.6 8
> 
> 1 SRCU-P.7 8
> 
> 1 SRCU-P.8 8
> 
> 1 SRCU-P.9 8
> 
> 1 SRCU-P.10 8
> 
> But, when I run it via:
> $ sudo tools/testing/selftests/rcutorture/bin/kvm.sh --duration 240 --cpus 288
> --configs "36*SRCU-P"
> 
> ps shows me only 7 qemu instances of 8 CPUs each. However, weirdly it is only 1
> thread for each instance (thus its not even 56 CPUs, but rather 7 or so).
> 
> 1496915 root      20   0 1684276 256996  66816 R  90.9   0.2   8:38.06
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 1496913 root      20   0 1684276 256996  66816 R  89.7   0.2   8:50.53
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 1496929 root      20   0 1684276 256996  66816 R  89.3   0.2   8:44.53
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 1496938 root      20   0 1684276 256996  66816 R  82.8   0.2   8:46.03
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 1496922 root      20   0 1684276 256996  66816 R  82.1   0.2   8:57.83
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 1496908 root      20   0 1684276 256996  66816 R  81.5   0.2   8:50.59
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 1496920 root      20   0 1684276 256996  66816 R  63.6   0.2   8:51.46
> qemu-system-aarch64 -enable-kvm -display none -no-reboot -smp 8 -net none
> -machine virt,gic-version=host -cpu host+
> 
> Thanks.
> 
> 
