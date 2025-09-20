Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C83221FC6;
	Sat, 20 Sep 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359276; cv=none; b=VfuwWiwiynBmOYIosAFbuAdq7NgvVJ7rPIyYwAESeOKNV649RQGRqfT1zUNe6C6BNwuXznKPZu0Q2nTcqSbkK74tIDMUFDcLgxR4jprKpEMhbgmVkyepggh54s5K7RP6vuKTxh0Sf+UL8XA3K9HPTHLs6NIObyYjNR14qo04MaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359276; c=relaxed/simple;
	bh=QoYmRi5QX/RJxFQK9UOVXg7sMqSEWO265RJWbQoNkzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzwnRBkCKV0IPxQVAkjTQ9BHG9AWeAD45fMWUjYKUuRhp4P+mgU8HQGL6EzLSXIcM5feF8gKHethwni0Kv11J64aUq+fHTI5R8AFHEieFMkW72sgaQ7SvflBxIcqz8K/A12hsTnBYvj1lJ8S0e4IAkdS43/3B5r6YZu/0Z9b2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JYIzycs6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JYIzycs6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758359265;
	bh=QoYmRi5QX/RJxFQK9UOVXg7sMqSEWO265RJWbQoNkzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYIzycs6vqNd2bDxwVjSJmnvDmr4qfpxKOSWC14nCAIEHGDui1DNmxM3YoQaqD+zF
	 EVKR+SsZ9w9Ekm6xJ1T0T3jrlRJkxl4GVIPLLK2QKrR1f+3Pj2gK9klcNvfozMJTPX
	 csR2n3wp+SHTi+izLtuoPItoZ27SV5wiPatoDH44=
Date: Sat, 20 Sep 2025 11:07:43 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: w@1wt.eu, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lance@osuosl.org
Subject: Re: [PATCH v2] tools/nolibc: make time_t robust if
 __kernel_old_time_t is missing in host headers
Message-ID: <b20a1126-9d59-4d8b-a85c-71ec532c2f8f@t-8ch.de>
References: <20250919014643.2776037-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919014643.2776037-1-zhouzhouyi@gmail.com>

On 2025-09-19 01:46:43+0000, Zhouyi Zhou wrote:
> Commit d5094bcb5bfd ("tools/nolibc: define time_t in terms of
> __kernel_old_time_t") made nolibc use the kernel's time type so that
> `time_t` matches `timespec::tv_sec` on all ABIs (notably x32).
> 
> But since __kernel_old_time_t
> is fairly new, notably from 2020 in commit 94c467ddb273 ("y2038: add
> __kernel_old_timespec and __kernel_old_time_t"), nolibc builds that
> rely on host headers may fail.
> 
> Switch to __kernel_time_t, which is the same as
> __kernel_old_time_t and has existed for longer.    
> 
> Tested in PPC VM of Open Source Lab of Oregon State University
> (./tools/testing/selftests/rcutorture/bin/mkinitrd.sh)
> 
> Fixes: d5094bcb5bfd ("tools/nolibc: define time_t in terms of __kernel_old_time_t")
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>                     

Thanks! Although it is fairly late in the developmment cycle I have
applied it to nolibc-next for 6.18.

(...)
