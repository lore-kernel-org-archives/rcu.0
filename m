Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174F382F1F;
	Sat, 19 Sep 2026 02:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789784040; cv=none; b=imcXghrTVvKz/A3gOpWfOuWpO59VkjQeeadhVtPbYmiT9zCjzmf5lveMISBSvnbRWVQ4zLQi7xkvHE05e9d7l2DX1FlVE13t0PxL2E3u9aFpFt1ECQI6MOOed/APfGuqeugG8iJTgvpIFgjAkqM87s1y9ZyU2yuofK8WqktGUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789784040; c=relaxed/simple;
	bh=hDPWRM+hDzCq3C3B7Flu6UMwT8nSQy01bi2z3VfdF6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uitFXpXuuxdgBb/XJc341DXQyKbKmJetxSH0evjoTj4Jab7q/pXqcNoorTGXyMxMGK7T/DoPlZ0Bz5HxB0ls41WNKs1C5rEojBp4qu8efvLipTCROgciFMOIBobArlrS5b+aFNrBWqGe36o2nZ9nPgXrIRye+WJtqY3wW655Dto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxV8mN4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxV8mN4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091911F000FF;
	Sat, 19 Sep 2026 02:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789784038;
	bh=QPPOCqh+PLLZeftBHXUi3hA0ScXBVUSC15GjSPLQPWw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=kxV8mN4e88le20LNAkx7s+XVU2EG+9NXiJTSXkpPHgH8Ol3Gz+pv2T9A6oDzTSIbU
	 CaDgWV27EEoUQ+UZqtwYVB6B9DX9fE0wc8CwMI1VkbRbVDmDiL5Dhnxkwa6rY+lsK+
	 Tg0VPZKpJjwA95TCYyl3kDt9vi5ZD7s/YYrV08Ou4fBx7AJTL+tFhjyy5wt1d6+e2A
	 XrhKK1M45ecfCAdBJdzGIOw8ay6RmG/6Ce8Sq9zZRk34j5MF6BfbFCkinbUGCsQwPI
	 1R/YbiWUIH8l/VcDdvLTNp13j5wb64/MLDwS/oeTDeNgkbVEvG2QOsKXL22I3hoNOM
	 vMqu43xLEzNFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B96B0CE1853; Fri, 18 Sep 2026 19:13:57 -0700 (PDT)
Date: Fri, 18 Sep 2026 19:13:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, lance@osuosl.org
Subject: Re: [PATCH v3] rcutorture: kvm-again.sh: Fix re-run failure on ppc64
Message-ID: <71b074e0-8fbe-4f01-9e70-5e24d74a7f6c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260919010606.2916865-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919010606.2916865-1-zhouzhouyi@gmail.com>

On Sat, Sep 19, 2026 at 01:06:06AM +0000, Zhouyi Zhou wrote:
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
>    the re-run on that architecture.  Drop vmlinux from the unconditional
>    list, and instead conditionally delete it only when the boot image
>    basename is not vmlinux.
> 
> In addition, identify qemu_binary before the copy step so that on
> non-PowerPC systems (where vmlinux is not the boot image) the vmlinux
> file can be removed immediately after the run directory is copied,
> saving storage before any tests run.  This also eliminates the
> per-iteration re-computation of qemu_binary and boot_image inside
> the qemu-cmd transform loop.
> 
> Tested on a local x86_64 machine and on a PPC VM of the Open Source Lab
> of Oregon State University.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Queued for review and testing, thank you!

							Thanx, Paul

> ---
> Changes in v3:
>  - Identify qemu_binary and boot_image earlier, before the copy step,
>    so that vmlinux can be removed right after copying the run directory
>    on non-PowerPC systems, saving storage.  This also eliminates the
>    per-iteration re-computation of qemu_binary and boot_image inside
>    the qemu-cmd transform loop.
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/testing/selftests/rcutorture/bin/kvm-again.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> index b5239b52cb5d..9060b3dc8926 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
> @@ -180,6 +180,9 @@ fi
>  
>  echo ---- Re-run results directory: $rundir
>  
> +qemu_binary="$(find "$oldrun" -maxdepth 2 -name 'qemu-cmd' -type f 2>/dev/null | head -1 | xargs -r grep -v '^#' 2>/dev/null | awk 'NF { print $1; exit }')"
> +boot_image="`identify_boot_image "$qemu_binary"`"
> +
>  if test "$oldrun" != "$rundir"
>  then
>  	# Copy old run directory tree over and adjust.
> @@ -189,7 +192,7 @@ then
>  		echo "Cannot copy from $oldrun to $rundir."
>  		usage
>  	fi
> -	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
> +	rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out} "$rundir"/log
>  	touch "$rundir/log"
>  	echo $scriptname $args | tee -a "$rundir/log"
>  	echo $oldrun > "$rundir/re-run"
> @@ -197,6 +200,10 @@ then
>  	then
>  		$arg_link "$oldrun/../../bin" "$rundir/../.."
>  	fi
> +	if test "`basename "$boot_image"`" != vmlinux
> +	then
> +		rm -f "$rundir"/*/vmlinux
> +	fi
>  else
>  	# Check for a run having already happened.
>  	find "$rundir" -name console.log -print > $T/oldrun-console.log
> @@ -217,7 +224,7 @@ do
>  	qemu_cmd_dir="`dirname "$i"`"
>  	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
>  	jitter_dir="`dirname "$kernel_dir"`"
> -	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
> +	kvm-transform.sh "$kernel_dir/`basename $boot_image`" "$qemu_cmd_dir/console.log" "$jitter_dir" "$dur" "$bootargs" < $T/qemu-cmd > $i
>  	if test -n "$arg_remote"
>  	then
>  		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
> -- 
> 2.43.0
> 
