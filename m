Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BE3F12D0;
	Thu, 30 Jul 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402082; cv=none; b=DJzqjkRWB9jg9aZJMKG9JVLe8dW94GMSfmGVL7FSvRtV/LonazIRX9EW+x49KWToqz+oWqLw9t8slh8hDMmBRTn7LPPbkPRvUtKa/smAujM+P622lQKIzkTnUPcvrfRQWVlY+f0Gw7bc+GGsYAUqoInefuw0C2q2JCMw3LEr1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402082; c=relaxed/simple;
	bh=EgrgXehS8Eem5zAeSBXtfk3b1tTF3b01oPe3aMZL8Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjNLpL0HAFyK9V0byRHNsNOVonvg354qCQGEpMjuMwDVRuYjTKeKeabau09hfqqO9ywvkqmKaR8hMskIPjk6iiy/nbmCIZ+5u8gsQvSy8KDzejm3BqPlSM03VYXtyTPtbZAwQ1noebfDrbS5DdCHR75XkHWs8R46RrbUdjU+IUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMAAyTQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMAAyTQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16F51F00A3A;
	Thu, 30 Jul 2026 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402080;
	bh=CepvrJSCofuW+Rbn27Rzxe0iX7nFeJvfMACrLN8SBXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cMAAyTQeOGqrx75vLFrjVKl+Q6ZyYvMe3VzKiXO3gT454huGwem31nWyXRv/q9dlS
	 E3hQqIi3kmO60/5toa+zlCHUuM+g8Wqeu3nhCRRJ+Sf0qZx2N3FkcFXK6YLhYRpLQr
	 t/KYFLKt7fKulDxc4uMA3avGCvf+riDMcZSldx4g+Drk+cDrNxW3LqOsYnI8qChyzL
	 7VHsgrGNTwXbiZ3BhGlFN+vSFe+V/f8AsAU+/6IPpBHgp5VswFdaspZ9ChgObfb20X
	 +Kdl7lpr/DuwRf+dyPvrYDM1Pns9x4LuCF0BroserOpfZgvlmji+6LlA5kagPgRpPY
	 2550ObpT+Lr8A==
Message-ID: <47b147f2-8c10-4ae4-8023-94839f1110a8@kernel.org>
Date: Thu, 30 Jul 2026 11:01:12 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] mm/slab: introduce kfree_rcu_nolock() and improve
 slub_kunit coverage
To: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <5342124c-4847-4e93-92a4-f3512928c4d1@kernel.org>
 <f97853e9-3021-4f20-81d3-4bb710ca444a@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <f97853e9-3021-4f20-81d3-4bb710ca444a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 05:08, Harry Yoo wrote:
> 
> 
> On 7/29/26 11:14 PM, Vlastimil Babka (SUSE) wrote:
>> On 7/29/26 10:20, Harry Yoo (Oracle) wrote:
>> 
>> ...
>> 
>>> 8:  8e69c83a1e52 ! 8:  aeaf2ab60046 slub_kunit: extend the test for kfree_rcu_nolock()
>>>     @@ lib/tests/slub_kunit.c: struct test_nolock_context {
>>>      -			gfp_t gfp = (i % 2) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
>>>      +			gfp_t gfp = (i & 1) ? GFP_KERNEL : GFP_KERNEL_ACCOUNT;
>>>       
>>>     - 			objects[j] = kmalloc_obj(*objects[j], gfp);
>>>     +-			objects[j] = kmalloc(64, gfp);
>>>     ++			objects[j] = kmalloc_obj(*objects[j], gfp);
>>>       			if (!objects[j]) {
>>>     + 				j--;
>>>     + 				while (j >= 0)
>>>      @@ lib/tests/slub_kunit.c: static void test_kmalloc_kfree(void)
>>>       			}
>>>       		}
>>>
>>> Link: https://lore.kernel.org/linux-mm/20260427-nolock-api-fix-v2-0-a6b83a92d9a4@kernel.org [1]
>>> Link: https://lore.kernel.org/linux-mm/6edebc2b-5f5a-4b9c-9a4c-564310acee1b@kernel.org  [2]
>>> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>>> Link: https://lore.kernel.org/linux-mm/872bd673-3d45-4111-8a41-31185db3ece5@kernel.org
>>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>>> Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org [1]
>>> Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab543be@kernel.org [2]
>>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>>> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>> 
>> Wonder what produced this weird block of assorted trailers? "b4 prep
>> --compare-to vX" never did that for me?
> 
> Interesting. I checked it again with `b4 prep --compare-to v4`, but the
> command didn't produce this. Looking at the cover letter
> `b4 prep --edit-cover` It's not even there.
> 
> Probably it was produced during b4 send --no-sign? hmm...

Hmm let's see if it ever happens again.

>>> ---
>>> Harry Yoo (Oracle) (8):
>>>       mm/slab, slub_kunit: register kprobe to trigger _nolock APIs
>>>       mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()
>>>       mm/slab: use call_rcu() in unknown context if irqs are enabled
>>>       mm/slab: extend deferred free mechanism to handle rcu sheaves
>>>       mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
>>>       mm/slab: introduce struct kvfree_rcu_head for kvfree_rcu batching
>>>       mm/slab: introduce kfree_rcu_nolock()
>>>       slub_kunit: extend the test for kfree_rcu_nolock()
>>>
>>>  include/linux/rcupdate.h   |  32 ++++++-
>>>  include/linux/slab.h       |  16 +---
>>>  include/linux/types.h      |   8 ++
>>>  include/trace/events/rcu.h |   2 +-
>>>  lib/tests/slub_kunit.c     | 190 ++++++++++++++++++++++++++++-----------
>>>  mm/slab.h                  |  52 ++++++++++-
>>>  mm/slab_common.c           |  81 +++++++++++++----
>>>  mm/slub.c                  | 220 ++++++++++++++++++++++++++++-----------------
>>>  8 files changed, 433 insertions(+), 168 deletions(-)
>> 
>> Applied to slab/for-7.3/kfree_rcu_nolock and merged go slab/for-next, thanks!
> 
> Thanks a lot!
> 
>> Used slab/for-next-fixes as a base for a better topic branch indepdencence.
> 
> Ah, I see. thanks.
> 
> So slab/for-next is not a good base unless it depends too much on
> existing commits on the branch?
> 
> And usually it's better to use the base (slab/for-next-fixes,
> in this case) of slab/for-next as a base?

Yeah. Hopefully we'll figure out some documented guidelines for this in the
upcoming mm-next meetings.

>>> ---
>>> base-commit: ffc64805cebac330b2a60b2f1f144fcc35b8ab46
>>> change-id: 20260615-kfree_rcu_nolock-e5502555992f
>>>
>>> Best regards,
> 

