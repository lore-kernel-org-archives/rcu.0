Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058003358DA;
	Wed, 25 Mar 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427687; cv=none; b=MN+gsjbnepye5PL/5s09C4LAxA3KrDfUKFxDTfTW+eyVWNPIXkqubifZm0SMYNv/+sayqocD3mQPakVmfiTViF5hmqqUD5xNIxr7dqu29PUKC8ZaoovuB9g1IttTziH1UQXY2a3q4BRzFE7QzM+L2uwDQgUobvdRBcnAjdYkcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427687; c=relaxed/simple;
	bh=ZltXuo3y0hZumFiHX9g2/4w1IoWynutuFUdVx5jC7ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9/3A4Ua8tEr0Zai/Dx7b4/skLDkb0MMV4H+/Wu3o1jKij0ZEdYSZkWvi30pj80ZghqT/icABXF2kzMKofV3HvyLUo/WRMMQYu04+34iPfWdVdps+QD2JlqA2vFWlonZY1x+fkRE1jgc5x8jA3NdeSH2z4gBOufDhUp+8Rg44WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZtJs5oS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZtJs5oS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472E2C4CEF7;
	Wed, 25 Mar 2026 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774427686;
	bh=ZltXuo3y0hZumFiHX9g2/4w1IoWynutuFUdVx5jC7ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jZtJs5oSkHBlvxcqGTv1K5bZuebrcPNeR+ep7pebrN7SXJFOvGsZSAlYV3NYuhVBR
	 Jy4Fs1vK/9M+rWFWnyLnBk6Sn4pWR4MCc2okQM9FGoHAfdVJobT+ccJGzRpmp2nJ/T
	 pj62Ea27WguWZQedAxbeiUFZ/1XXBw4LDlkFHxAdxMhT9sIHNhYzfOCBW/KolsbUZq
	 G2Vq6/wl9GATQHfV76daayv0LVS7jBfU9YBJRhijwb1CDZkBq917IIS3F+wc9rStI4
	 2oxABWp1VaB9ONp2/zx28YmnCL/RqUmUK1wX58MWZNXnso36YDpraGseF7JlCTshQ+
	 c1SWVqN7Z+GXA==
Message-ID: <de209b21-a39a-4c8e-8f13-458d095c1325@kernel.org>
Date: Wed, 25 Mar 2026 09:34:40 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab,rcu: disable KVFREE_RCU_BATCHED for strict grace
 period
Content-Language: en-US
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dmitry Vyukov <dvyukov@google.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
 <ff139493-1964-4285-947d-1b43fe40f8e5@kernel.org> <acOa8ErxLgbj0Uer@hyeyoo>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <acOa8ErxLgbj0Uer@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/26 09:21, Harry Yoo (Oracle) wrote:
> On Wed, Mar 25, 2026 at 08:50:07AM +0100, Vlastimil Babka (SUSE) wrote:
>> On 3/24/26 22:35, Jann Horn wrote:
>> > Disable CONFIG_KVFREE_RCU_BATCHED in CONFIG_RCU_STRICT_GRACE_PERIOD builds
>> > so that kernel fuzzers have an easier time finding use-after-free involving
>> > kfree_rcu().
>> > 
>> > The intent behind CONFIG_RCU_STRICT_GRACE_PERIOD is that RCU should invoke
>> > callbacks and free objects as soon as possible (at a large performance
>> > cost) so that kernel fuzzers and such have an easier time detecting
>> > use-after-free bugs in objects with RCU lifetime.
>> > 
>> > CONFIG_KVFREE_RCU_BATCHED is a performance optimization that queues
>> > RCU-freed objects in ways that CONFIG_RCU_STRICT_GRACE_PERIOD can't
>> > expedite; for example, the following testcase doesn't trigger a KASAN splat
>> > when CONFIG_KVFREE_RCU_BATCHED is enabled:
>> > ```
>> > struct foo_struct {
>> >   struct rcu_head rcu;
>> >   int a;
>> > };
>> > struct foo_struct *foo = kmalloc(sizeof(*foo),
>> >     GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
>> > 
>> > pr_info("%s: calling kfree_rcu()\n", __func__);
>> > kfree_rcu(foo, rcu);
>> > msleep(10);
>> > pr_info("%s: start UAF access\n", __func__);
>> > READ_ONCE(foo->a);
>> > pr_info("%s: end UAF access\n", __func__);
>> > ```
>> > 
>> > Signed-off-by: Jann Horn <jannh@google.com>
>> 
>> Hm but with 7.0 we have sheaves everywhere including kmalloc caches, and
>> there's a percpu rcu_free sheaf collecting kfree_rcu'd objects.
> 
> Right, but only when CONFIG_KVFREE_RCU_BATCHED=y
> 
>> Only when
>> it's full it's submitted to call_rcu() where the callback rcu_free_sheaf()
>> runs slab_free_hook() including kasan hooks etc. If there's nothing filling
>> the rcu_free sheaf, the objects can sit there possibly indefinitely.
> 
> Right.
> 
>> That means CONFIG_KVFREE_RCU_BATCHED now handles only the rare cases where
>> kfree_rcu() to the rcu_free sheaf fails (and I still owe it to Ulad to do
>> something about this).
> 
> Right.
> 
>> So to complete the intent of this patch, we should perhaps also skip the
>> rcu_free sheaf with RCU_STRICT_GRACE_PERIOD? (or with !KVFREE_RCU_BATCHED
>> perhaps as it's also a form of batching).
> 
> Maybe I'm missing something, but...
> 
> by making KVFREE_RCU_BATCHED depend on !RCU_STRICT_GRACE_PERIOD,
> selecting RCU_STRICT_GRACE_PERIOD disables all uses of rcu_free sheaves?
> 
> kvfree_call_rcu() implementation on !KVFREE_RCU_BATCHED does not call
> kfree_rcu_sheaf().

Ah yeah, I missed that there are two kvfree_call_rcu() implementations and
kfree_rcu_sheaf() is only used in the batched one. Sorry for the noise.

Will queue the patch

>> But then I wonder if the testcase in the changelog appeared to be fixed with
>> this patch on a 7.0-rcX kernel (base-commit: below is rc3+) because by my
>> understanding it shouldn't have been. (unless there happened to be enough
>> kfree_rcu() activity on that cpu+kmalloc cache combination, so that the
>> rcu_free sheaf got submitted withing that msleep(10)).
>> 
>> > ---
>> >  mm/Kconfig | 1 +
>> >  1 file changed, 1 insertion(+)
>> > 
>> > diff --git a/mm/Kconfig b/mm/Kconfig
>> > index ebd8ea353687..67a72fe89186 100644
>> > --- a/mm/Kconfig
>> > +++ b/mm/Kconfig
>> > @@ -172,6 +172,7 @@ config SLUB
>> >  config KVFREE_RCU_BATCHED
>> >  	def_bool y
>> >  	depends on !SLUB_TINY && !TINY_RCU
>> > +	depends on !RCU_STRICT_GRACE_PERIOD
>> >  
>> >  config SLUB_TINY
>> >  	bool "Configure for minimal memory footprint"
>> > 
>> > ---
>> > base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
>> > change-id: 20260324-kasan-kfree-rcu-4e7f490237ef
>> > 
>> > --  
>> > Jann Horn <jannh@google.com>
>> > 
>> 
>> 
> 

