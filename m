Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC511DFD9A
	for <rcu@vger.kernel.org>; Sat, 16 Aug 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310708; cv=none; b=jmcqRykbXc1hUInuwqdx/eH4XR0y98H8RkRIs8u8Wr+EpPnZ3sxoZZIfNikQ2vgl0o/hNDAI3lClCOOb8U/7RT4GnAvwYyGPG0MecUYJOaFIUTcOaRMfO31kE6n53xKfm2ZSUkLhHFYs+DQMuj+8wqRlrnnfXgUyBRn9dywud2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310708; c=relaxed/simple;
	bh=wUGIvKrpeupzIRgkLjoxvnnL4aYCz4wqe6Y1gDPHbAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po5lLG3sUclnJIHZJKPfyQMGNDye0CGm+ATZwFYuIc5xncWaDbbE5bhQdeH6vy3j2qxsjjq7mIz5Tjr8HrIHOP0v0i9CNGYhnN02T5HuvYgOyFlUjp9XFhswm2fwxqleEqZA9Wwmcb2gKNVmmaXHSf6CoFOC/7dF4p5+Swp/z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H3aCE55t; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H3aCE55t"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so575965a12.1
        for <rcu@vger.kernel.org>; Fri, 15 Aug 2025 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755310704; x=1755915504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwsXpXXIuYQCL/FW90IpYibOz6Dfp82j0b3aRU8rwPo=;
        b=H3aCE55tHzz6WyPbYzCUrIo+ItI9OxGSKAoOHBd9+VdEnZJQZAuoxK6SW11sMlk4XV
         RZ9swmz5Z/S2AuD8Qve3WSn7y8QJONm7FNvw+v/LApoP7IhpsNbvJgYXnKkR4qX+Caw2
         AQQjReLbjSEwz4egINy+HNBZ8s6ei2JqdYMcp2P7k98JEEFQYV2c/qe3rbr1MxPl8qEH
         TJ60zK831q0fWwtlJ6ppGoQVYnKmIngPCOBeXf4IAbM0R38B2N/NaCglmgdqHQtwcvR5
         qlJlo+bBmFX/7BSXEE6XcI5FYwat8EDf0egsspx15KoUoUCshIsVaknZeHQRrF6DB8KI
         Bqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310704; x=1755915504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwsXpXXIuYQCL/FW90IpYibOz6Dfp82j0b3aRU8rwPo=;
        b=qm7wnP/FWZwZ+920ghJx3rlUELZnm86lb67ySEwiqBwf2lu7fqxjlAsENo7oUvPvcw
         4nUXVkxqfC81Wajdg6oYHXGSbUchezrHTU4Ud2rpQyPfgkqMlXTtBwagMXaCgTdx8UVf
         yhgwz2Pn1cX5SErJc6P91axo37GVdPTCgipjZwV9LH72CB6Qy+OGOI7bg9HsBzCm5tJy
         Xek7tqgZUOjWxNMILikUOjyRd0FW+n2VfKt6pzJlErLllPjt4htR+/4l6fdtxOx6QXpk
         jQetwXG5OJ4mQdNxvQvnyh6cr2fYAu0Lfbk5V4r2z7D78ptb7rVcsoUS1gzYP7IXcXfo
         JL1A==
X-Forwarded-Encrypted: i=1; AJvYcCWCWYBnLTs1sfXgvYvlP4etRDkfHDWVsnGA2sWBYnbKFN/u5jfgmhyOhVoHMWeQkqHyJQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzljFcrA6jit2y4uIVfZ0FQH+Xdj4yCc6pWs1uQDw9uPIc+9u8
	5Y1eZbLb73HRQkYOAviLss7m8o+PntQqIRInGeVa0tdsnpUD3BiH5IS+/lNH33Rnhg==
X-Gm-Gg: ASbGnctkah18IVTJPyT3PltNZk89gQDqQ3A4M/GkGyz5m6+ngvqjoTCxRMVIot23xiF
	2rpE3fUcejf551gMBd20WG3rga9dwuVi+KTpJR1vmLcRGJ9OeJ8TpNGkDPdkRLkAFtmBmn43TbI
	MpAQlp265XpSLHZorLn0kLGa14XhXQLcQOfIhfOaa2A2742FWYhhmo3KP6HVtxz4lh1dCzA1Rm5
	kQxHw+ZK1sFuD7WKhg66Oj7e1ZpBWOUwvNGXK7IieErNvn8T90unfp4Y4BjQYG0y/fnghKlTclh
	cwT7CrAMMhmfdqBvpLvIsfYKWyy0KoLvXrtkfuvwzZNXcPASEUJQZXzrDgGXvle+7s7+Qob4m0D
	UlMCGd62LydrN7b9e1YDjDQ==
X-Google-Smtp-Source: AGHT+IHNk8PBKUNrSPx10ifAUYOJvFnn2Jc4DOTuWB3OZc7DjYdpAwzxQ0MKpk/V8JZvySJfquvRNQ==
X-Received: by 2002:a17:907:7f09:b0:ae3:5185:5416 with SMTP id a640c23a62f3a-afcdb1a2e5amr388545866b.13.1755310704049;
        Fri, 15 Aug 2025 19:18:24 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01168csm262745266b.91.2025.08.15.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:23 -0700 (PDT)
Date: Sat, 16 Aug 2025 02:18:21 +0000
From: Wei Gao <wegao@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, kuniyu@google.com,
	kraig@google.com, lkp@intel.com, netdev@vger.kernel.org,
	dsahern@kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, edumazet@google.com, horms@kernel.org,
	oe-lkp@lists.linux.dev, kuba@kernel.org, pabeni@redhat.com,
	ncardwell@google.com, davem@davemloft.net, ltp@lists.linux.it,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
Message-ID: <aJ_qbZDvDJwVoZGA@localhost>
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508110750.a66a4225-lkp@intel.com>

On Mon, Aug 11, 2025 at 01:27:12PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash" on:
> 
> commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: ip: order the reuseport socket in __inet_hash")
> url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-ip-order-the-reuseport-socket-in-__inet_hash/20250801-171131
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 01051012887329ea78eaca19b1d2eac4c9f601b5
> patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2@chinatelecom.cn/
> patch subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
> 
> in testcase: ltp
> version: ltp-x86_64-6505f9e29-1_20250802
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs_perms_simple
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> 
> 
> kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 

This kasan error not related with LTP case, i guess it triggered by network
related process such as bind etc. I try to give following patch to fix
kasan error, correct me if any mistake, thanks.

From: Wei Gao <wegao@suse.com>
Date: Sat, 16 Aug 2025 09:32:56 +0800
Subject: [PATCH v1] net: Fix BUG:KASAN:slab-use-after-free_in__inet_hash

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index da500f4ae142..5def9009c507 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -57,7 +57,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
  * @node: element of the list.
  */
 #define hlist_nulls_pprev_rcu(node) \
-       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
+       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))

 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
@@ -175,7 +175,7 @@ static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
 {
        WRITE_ONCE(n->pprev, next->pprev);
        n->next = next;
-       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
+       rcu_assign_pointer(hlist_nulls_pprev_rcu(next), n);
        WRITE_ONCE(next->pprev, &n->next);
 }

--
2.43.0

