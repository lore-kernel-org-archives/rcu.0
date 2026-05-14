Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F1330662;
	Thu, 14 May 2026 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750750; cv=none; b=ARz7Ien4OPE9AYvovjgCXPg+gxG4OXoWFL3ChubqI1j1u/jsc10T+Rxr/zW/Gzq/GWCpfp/HruacJtlf2AnREWKXQa5bLqNhzSDrcllqQcip6GP8/iNcHOrrEZssSV3IDSuTyaqdVuwjdNtP8zjV3qgFy5X6Rqy0l6peRUds7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750750; c=relaxed/simple;
	bh=M4WVs7iBLmP4pE2MrA1L5Ry/mhmsTAqWHCyv7F6kDE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obzRb7wm8K/7uPzU99eUGSSk1sBsUylicwhQHkqMUrqaKTBjDG7i8cmg9/Uss9ZFD3BRpwNeIMXrkOEXfzi7hWR41B4nRaTLCpyqiB6D3GkngRPKUvoAGEbMTF/5mW8Kkdhj77oPgZZc80p9B283EvYaFM5/4wnY8Rcp5jbQ20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm4lvvxQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm4lvvxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE81C2BCB3;
	Thu, 14 May 2026 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778750750;
	bh=M4WVs7iBLmP4pE2MrA1L5Ry/mhmsTAqWHCyv7F6kDE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm4lvvxQYFKUIbFeIz8z5QsUYZlNiTLDN0fTlrC3hi+xEmVMeo/kNl6101yz4VKJZ
	 r8v0iNrK14k5XvhE5Jy7ouxv3NDdOsDHptrWTf52a29T0+WJbixavx9sy4NHLYfw2L
	 lP1vmOgFj6U3X55Iq44Yillywj+W53k7w/77ihzhEAIhuU+FUJhugRiND9ecNCU7Xb
	 Bz15FhLvemp6sFehnokb18RIHrumIW/tM1mgudrygY/H/HBelEwBbKAE/aoRec+ft4
	 QJpE2BrsibF3oJwfWFk9LA4JNl1TBfWNmxnwYmoXWeK0mB0yFxo/FcxwM5QzocDoqc
	 1GHegVmZ8XCiw==
Date: Thu, 14 May 2026 18:25:47 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Levi Zim <i@kxxt.dev>
Cc: linux-mm@kvack.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
Message-ID: <2dhbxmhg4l35gupk3wgwtufsf735rnk4czmcoyspzckvexie3z@nswohkoipx44>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
 <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
 <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
 <1315d145-49ee-412f-ad91-0f6c61c4c2c9@kxxt.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1315d145-49ee-412f-ad91-0f6c61c4c2c9@kxxt.dev>

On Wed, May 13, 2026 at 09:34:01PM +0800, Levi Zim wrote:
> On 5/13/26 9:42 AM, Harry Yoo (Oracle) wrote:
> > On Tue, May 12, 2026 at 09:46:33PM +0800, Levi Zim wrote:
> >> I don't know how could we fix it otherwise after removing BPF memory allocator completely.
> >> Could we find a path to move forward without causing regressions on architectures without HAVE_CMPXCHG_DOUBLE?
> > 
> > Probably we can. Could you please see if this works for you?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git/log/?h=slab-kmalloc-nolock-without-cmpxchg-double-rfc-v1r1-wip
> 
> Thanks a lot! I tested it and could confirm that it could fix the failure of
> bpf_task_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE) on riscv64.

Thanks for confirming!

I will add this to TODO and post them and Cc you when submitting it to
the mailing list.

> The commit message says that the allocation may still fail if the slab lock
> acquisition fails upon the first try.

kmalloc_nolock() can always fail, unfortunately.
We can only make it less likely to fail.

> But this is still a great improvement
> compared to the previous always failing code.

Yup. Thanks!

-- 
Cheers,
Harry / Hyeonggon
