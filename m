Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA930F7F7;
	Mon, 22 Jun 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140228; cv=none; b=sl8X03hhpSiL2R3B/zkiuX0v1hzEphRKyhPcTjkFo4ARNDf5IMHXymiS3gjO+Kbup2oR7OMJijZEVEjJjeOF21TBfasGRwxs3QnImUJ8p5DpeXjNu9Q6U8+TSGqDC3rlKG/dyGy6ht/TdL6MhECVFwcc5IPp4/NWiSuluznCOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140228; c=relaxed/simple;
	bh=ls1aKeEBaLQTrlIokG9gdBDm2npsXmymoREjIx9I8no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZbpugKy1x46WH2gWJmCJxRTCX3yEUl6iBDwMhhOVJBJW0Vk77HTvLUJl3JZLPBR6x2JWPEmAVDqA5ewAz0/5Cq7ZIcKgLKHMioB0V4Ul6Lt4AjLVMm+a+l3ufGM+px33e2dvQslarBfQ+ccsWmUFK6M0j/F14ujM2oRqOJ9obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bb2FxCcg; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bb2FxCcg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782140220; bh=CGU6np4obOJiJQaY07OnznTkGUZ3Y1DTcJV4GO2zAMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bb2FxCcgDgOebEcjlj4dq2Jf1DJ+VR3VNCMIrnZPGAFNlMTDDkLGNBj1qlTl6CLwe
	 Giorm7LAHGXf2sM9iNctgy5ZvmXxiRyJx4nkprHOg3aSgdSSeSfVPoetTMYD0gHw5e
	 HQNl7J61T/bm3Vaixiqi3Koyrpwq/cQwL37CLvW8=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: OKOirRU4nj6hL/Cx4EiS/nyJjhfozdbVDml+cV3gyTZ/RghjWx652Gmqqy4ULZ
	 48y3VDdpE58CAeQNu4fQOpnTejNbkWv2RwOBoLUiedS5AnUfUZwY4bzy3fvTiwxTKRqUR6zc0UY5w
	 zEgtxCdJq21kdyVO7R5dSJLlugmDjiA6vkkAqFGcc/dojoBleZf0WYYsl+jHv9RUsWF8/4RZe5yCG
	 HzB6iDdsRRPCbgZxvzNVq+//Rnj2ttwbssJZxpZP6KamrVj1SS+5sBWGVbt7Q3lBCCjTbcyn1NhsD
	 jIWiGsVi43VbuueczGeQoYenZKAJNKsLQGWuGzyH9cajxeIvRpj+XDHzY/Y/Xxr2pVUekNlNqS57g
	 UTEICULC3XqCVv2s66kTRSxQmlwebhUg3JIxpGwX3rCOS4aNre4L79TO+HeuNbjiBF4ZgdKJI2Nvh
	 f/jlN2wyOtiPza40iUD+YfXdNtCIj2VRT2AC7a6XjmDhIq04ohkb91W3syqR307rgnjbG42oWLEZx
	 hCRqjMA41yaF0U4IIX5mZtdSOYZwlhUVyBh6/1eLiAnjtZ+D3pOwY+uspCZ5+HH8i7N8FquDSFCG9
	 vNcEzUy1OWZXhOj11p3XBQVjg54v4bf/4Ne16vn5OgcaPhqlg97uI/94t/EsAMAAY9tZp+S3xGju9
	 SfSwVHckP3mc0+hstJf4myMqi7CwvV7X1fWXnkkToYTqUZWiQGfbtlSbCFbSqcW9W1WxHEH5dYfFo
	 8x6otELUAkDsQTTB7TJU2Vdl5lC4o0OU2Y7WtZQL5xZpt4mvMcXedOss1ADOXydE7pK1Ehl4FawCP
	 X1luAQdIBxbRNCWtVXFxL7qmVbkb37jBNqHYZ1uklgYC0MtMV8pgvXzTNKjVLBEEpgmK1WNaQJEtI
	 RIyybKBtJlkhIQJN/308mq78gVLtFrP4W8U7Wx0whAmxI7wckhfeAC2kD8ACcDOIRWToTnzwYr8qr
	 mYXly0f7xHmOqfS1nZEuXbMbyWZxVzdrOj0Wlm4PVua6Y+QzjfnxEe5kJOK0x17yAB9arlqGaNRBe
	 ABDve+MGh3TCuwFFQzBEmpgLiPfI+C5AeecP6T2fmohcAycp05GW2xGBqHcpMhWSoJcDPoKdfxlvI
	 1+TOFujjXMk3vXq3evNy6Fh/KcC3juqI/3q1aB7eF774oA==
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id E363CE35; Mon, 22 Jun 2026 22:56:54 +0800
X-QQ-mid: xmsmtpt1782140214tw1rxxvxs
Message-ID: <tencent_12A1049445F2CE248F20CB235AC111353A0A@qq.com>
X-OQ-MSGID: <d35872f1-c62e-421d-92fc-7ec1c3d32652@qq.com>
Date: Mon, 22 Jun 2026 22:56:53 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
To: Harry Yoo <harry@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
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
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
 <tencent_45CAE878B5922990DB102BE05A1BAD50DA09@qq.com>
 <e54ce8be-9480-4583-9c6a-d0dbe1378f53@kernel.org>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <e54ce8be-9480-4583-9c6a-d0dbe1378f53@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harry,

On Mon, Jun 22, 2026 at 02:28:44PM +0900, Harry Yoo wrote:
 > On 6/21/26 9:29 AM, XIAO WU wrote:
 > > I was able to reproduce this in QEMU with KASAN.  The trigger is as
 > > simple as passing a large (>8KB) kmalloc buffer to the new function.
 >
 > Thanks for taking a look, but this was intentional.
 >
 > I should have documented that only kmalloc_nolock() ->
 > kfree_rcu_nolock() is allowed and kmalloc() -> kfree_rcu_nolock()
 > is not allowed (yet).
 >
 > Since kmalloc_nolock() does not support large kmalloc, the warning
 > is not supposed to trigger. That is why I added only debug warnings.

Thank you very much for taking the time to explain — I really
appreciate it, especially since I'm still learning my way around the
mm/ subsystem.  You are absolutely right that kmalloc_nolock() returns
NULL for sizes above KMALLOC_MAX_CACHE_SIZE, so a proper caller using
the kmalloc_nolock() → kfree_rcu_nolock() pairing would never hit this.

I did notice one small thing that I wanted to gently bring up, though.
Please forgive me if I'm missing something obvious here.

When I was reading through the surrounding code to understand the
pattern better, I noticed that kfree_nolock() — which has the same
"only for kmalloc_nolock()" constraint (documented in the comment at
mm/slub.c:6828-6835) — actually does check for a NULL slab:

   void kfree_nolock(const void *object)
   {
   	...
   	slab = virt_to_slab(object);
   	if (unlikely(!slab)) {
   		WARN_ONCE(1, "large_kmalloc is not supported by kfree_nolock()");
   		return;
   	}
   	s = slab->slab_cache;
   	...

So kfree_nolock() gracefully returns with a warning even though it too
expects only kmalloc_nolock() callers.  That pattern seemed really
sensible to me — it costs almost nothing and prevents a panic if
someone ever passes the wrong pointer (which they shouldn't, but as you
mentioned, the constraint isn't documented on kfree_call_rcu_nolock()
yet).

I also wondered about the difference between WARN_ONCE (used in
kfree_nolock) and VM_WARN_ON_ONCE (used in kfree_call_rcu_nolock).  If
I understand correctly, VM_WARN_ON_ONCE compiles away entirely on
production kernels without CONFIG_DEBUG_VM, which would make the
subsequent NULL dereference completely silent — no warning, just a
panic.  That seems a bit scary for something that's exported to
modules via EXPORT_SYMBOL_GPL.

And since you mentioned that kmalloc() → kfree_rcu_nolock() support is
planned for the future (the "yet") — wouldn't this code path need the
NULL check at that point anyway?

I was thinking something like this would make the function consistent
with kfree_nolock() and also make it forward-compatible with the
planned kmalloc() support:

--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1266,10 +1266,16 @@ void kfree_call_rcu_nolock(struct rcu_head 
*head, void *ptr)
  {
  	struct slab *slab;
  	struct kmem_cache *s;

-	VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr));
-
  	slab = virt_to_slab(ptr);
+	/*
+	 * kmalloc_nolock() never produces large-kmalloc or vmalloc
+	 * addresses, but be defensive: fall back to defer_kfree_rcu()
+	 * for unsupported pointer types, consistent with kfree_nolock().
+	 */
+	if (unlikely(!slab))
+		goto fallback;
+
  	s = slab->slab_cache;

  	if (__kfree_rcu_sheaf(s, ptr, /* allow_spin = */ false))
  		return;

+fallback:
  	defer_kfree_rcu(head);
  }

Of course, this is just a suggestion — you know this code far better
than I do.  If you feel the current code is fine as-is with proper
documentation, I completely understand and won't press the point
further.

Either way, thank you again for the explanation, and for working on
this series — having kfree_rcu_nolock() available for BPF and other
contexts will be really valuable.

Thanks,
XIAO

