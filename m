Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933D15442C;
	Thu, 18 Sep 2025 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225705; cv=none; b=KzXR87dcWLCZCWfKpGzKWBJQgowx0C0pXgHYYXJpmXnPllbZai/j+MGnfWAMb37iEwNSjf8x0Qhf92GEjGODnHqt3MRruqvQu/fvxq3YjMCbmTBksnRkilm87LQ9RJWOZiVDq7eUQK7eiz6G5hILGF8vN91RUf/VgEV5Bfd0VRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225705; c=relaxed/simple;
	bh=LxDvrxY2bwQJFsQKv7V85HYqrETwbOshcRCYEPOyloM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdljpkxID/5DuWldtGvlwSSpmKfChpJyDZlr8Xaa1f0fxxTnUJWDS255Dd+3/EcDXZfhgEKB/ibnai/Ic/jUSFnXzJ3o0c58TIq5VlWfk3VX2FB9CVCFoA2kpxQn7l6xmMO43sZ6lpvvds2rM5sDP1cEWL4PFROIYJhv8prM2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PqVqB+Cu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PqVqB+Cu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758225696;
	bh=LxDvrxY2bwQJFsQKv7V85HYqrETwbOshcRCYEPOyloM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqVqB+Cuk9ACRvIgiHJRoXQt9di8KTVK4MWHR4KVM/rJySWN/lPVP0tSgdBO0mQe9
	 bWRSaCsz6YGXluH+avcSZhsIRLcubblyKO64T2IcUTGBM/ThfEgbtTKt5RtPWerv0N
	 lDyfmqU4oXywXXYFFtM8bzTsh4FUmNRc7isj7lXo=
Date: Thu, 18 Sep 2025 22:01:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: w@1wt.eu, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lance@osuosl.org
Subject: Re: [PATCH] tools/nolibc: make time_t robust if __kernel_old_time_t
 is missing in host headers
Message-ID: <6aa8f3da-05b8-482f-ae14-a1a67a393ebf@t-8ch.de>
References: <20250918010833.2760723-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918010833.2760723-1-zhouzhouyi@gmail.com>

Hi Zhouyi,

thanks for your report and patch!

On 2025-09-18 01:08:33+0000, Zhouyi Zhou wrote:
> Commit 
> d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
> made nolibc use the kernel's time type so that `time_t` matches
> `timespec::tv_sec` on all ABIs (notably x32).    

FYI you don't need to keep the referenced commit message on a single
line and should reflow it like regular text:

Commit d5094bcb5bfd ("tools/nolibc: define time_t in terms of
__kernel_old_time_t") made nolibc use the kernel's time type so that
`time_t` matches `timespec::tv_sec` on all ABIs (notably x32).    

(Source: I did the same thing as you until Linus told me to stop)

> Some distributions (e.g. Ubuntu 20.04 on ppc64le with older
> exported headers under /usr/include) do not expose
> `__kernel_old_time_t`, causing nolibc builds that rely on host
> headers to fail (I discovered this when doing RCU torture test in
> PPC VM of Open Source Lab of Oregon State University).

Instead of mentioning Ubuntu 20.04, just explain that __kernel_old_time_t
is fairly new, notably from 2020 in commit 94c467ddb273 ("y2038: add
__kernel_old_timespec and __kernel_old_time_t")

> Keep the new behavior, but add a small compatibility shim:
> if `__kernel_old_time_t` is not available, fall back to
>  `signed long`
> 
> This preserves the intent of d5094bcb5bfd while letting nolibc
> build on systems with older exported headers.
> 
> Fixes: d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>    
> ---
>  tools/include/nolibc/std.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
> index ba950f0e7338..ea225a0b16e9 100644
> --- a/tools/include/nolibc/std.h
> +++ b/tools/include/nolibc/std.h
> @@ -29,6 +29,10 @@ typedef unsigned long       nlink_t;
>  typedef   signed long         off_t;
>  typedef   signed long     blksize_t;
>  typedef   signed long      blkcnt_t;
> +#ifndef __kernel_old_time_t
> +typedef   signed long        time_t;
> +#else
>  typedef __kernel_old_time_t  time_t;
> +#endif

I don't think this works as __kernel_old_time_t is never defined.
Instead we could switch to __kernel_time_t, which is the same as
__kernel_old_time_t and has existed for longer.

>
>  #endif /* _NOLIBC_STD_H */


Thomas
