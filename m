Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1751C01;
	Wed, 16 Sep 2026 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517570; cv=none; b=heBK9qqioiNTXekOnPwGPccryDjKy1aOqwuwPz3O9vUCnrNcGEKPW6b1ilQ1TSLM7f9T/4F40wmCnlZMc0Iy1DrLaJ+L3WGRrtfABMfyXY7mOK3oo15AqdrHjTVhyfw3EKpjyaHwCV8qMPsq5AWtbj3wj+8A6S+gLcHnid3Bs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517570; c=relaxed/simple;
	bh=7PwFjTGGND1ePQAK8SZBqsnF0MrkIJIDgE4awiIrsWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkbI1FUR5Mh5w7RnMsKimcQo179em3pqtV/76SBJEZ93yY1CCvI5GmxMJ4sTTIemQsI3rSaoq7Iu2TVGEWzqeER67QMAthxcenW/sKmnqAeSLycGqhSBPtBULJUZSpr3ZWlZ0jT+Uamz99kt2dob7+0nF1FVDtPWdhaDyAXM7Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Uw8QJS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Uw8QJS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3481C1F000FF;
	Wed, 16 Sep 2026 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517569;
	bh=tZdii42B9G3uXfODq26MzP1EJMnbFchcxUaVAb/qszU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=W3Uw8QJSscTeeBGes9J/kqtVF0rysQQsQJSRzhQ88uW3sOYZFIrRc+CCd8s7nuTDS
	 ZcHvhIPoIhYcsfEhhe83Gz+p4d9UAV9xMxf/izwVM5BHIKar7PA4KuXQmBBOP3c+5Y
	 1oI9iZcDeXjGtN0jqzqUWKqveZV2qMcXUBIzUC8YlQuFKW++55n97gOtYssiuy27j8
	 ECki/65H2E58ki2ukNHO/bej1/hlU6LqgiODdf8Y/CQg5D4+N09gKyMgN4tJI2FwYM
	 ae2O3YI5G6P9L0sBIa1sUttX02d1FGvrLBqxm+uQbojgOgWVObJ7tUa9r9cafkvLER
	 46Gts94lKVHsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AECAFCE0996; Tue, 15 Sep 2026 17:12:48 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:12:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH v2] rcutorture: kvm-again.sh: Fix re-run failure on ppc64
Message-ID: <e2f5f0c1-526f-4410-a085-f030208d1731@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260915085949.3708122-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915085949.3708122-1-zhouzhouyi@gmail.com>

On Tue, Sep 15, 2026 at 08:59:49AM +0000, Zhouyi Zhou wrote:
> Discovered in the Open Source Lab of Oregon State University when running
> torture.sh on a ppc64le VM.  Two bugs were exposed:
> 
> 1. The kvm-transform.sh call hard-coded "bzImage" as the kernel image
>    name.  On ppc64, the boot image is vmlinux, not bzImage, so the
>    re-run failed to find the image.  Fix this by extracting the QEMU
>    binary from the qemu-cmd file and passing it to identify_boot_image()
>    to obtain the correct architecture-specific image name, the same way
>    kvm.sh already does.
> 
> 2. The rm -f invocation on re-run listed vmlinux among the files to
>    delete.  On ppc64 vmlinux is the boot image, so deleting it broke
>    the re-run on that architecture.  Drop vmlinux from the list.
> 
> Tested on a local x86_64 machine and on a PPC VM of the Open Source Lab
> of Oregon State University.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good catch!!!

One additional request below.

> ---
> Changes in v2:
>  - Remove blank line between qemu_binary and boot_image assignments
>    for cleaner style.
> 
>  tools/testing/selftests/rcutorture/bin/kvm-again.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> index b5239b52cb5d..cacc9f2b230d 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> @@ -189,7 +189,7 @@ then
>  		echo "Cannot copy from $oldrun to $rundir."
>  		usage
>  	fi
> -	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
> +	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out} "$rundir"/log
>  	touch "$rundir/log"
>  	echo $scriptname $args | tee -a "$rundir/log"
>  	echo $oldrun > "$rundir/re-run"
> @@ -217,7 +217,10 @@ do
>  	qemu_cmd_dir="`dirname "$i"`"
>  	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
>  	jitter_dir="`dirname "$kernel_dir"`"
> -	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
> +	qemu_binary="`grep -v '^#' $T/qemu-cmd | awk 'NF { print $1; exit }'`"

Would it be possible to identify qemu_binary earlier so that if the
binary is not vmlinux, vmlinux can be removed?  This saves quite a bit
of storage for non-PowerPC systems.

							Thanx, Paul

> +	boot_image="`identify_boot_image "$qemu_binary"`"
> +	kvm-transform.sh "$kernel_dir/`basename $boot_image`" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
>  	if test -n "$arg_remote"
>  	then
>  		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
> --
> 2.43.0
