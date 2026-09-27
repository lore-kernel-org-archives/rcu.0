Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4C547059;
	Sun, 27 Sep 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790539432; cv=none; b=ahikjSD9ZAWmRwsfOV64z4+lxIQmHFeqqKppgzQI8tGFuKetzmUDI0QlLjLslhlm6TH75B1wil0zZWr9PUxAQ0xFwgj+tJFUIllytBl1D1FEt4c0TH5EXIcFJXPocbzvYm8h+suNFyETcXI4NxxJQvCEIjABVGQpnnjtF9QdPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790539432; c=relaxed/simple;
	bh=qW6h8WAnNsfCgvtFtQyNP/MRWuvgMahJGJpAevIuHGM=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=L8SM+JQWFL/rNhT2y/divwwkn2oNyY3v1FmeKaEFfHb2jG3etSKTMzjhyx57FJkNLeYLdbRK++y53ASRuh99lLz01f8UPPD17ggHvh5rUfttC3bwwHqIcnrx7rpdp4c8n88FAVJKv+5lupdQFzc+t++ScmZPAFMxth4VZUdWk2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fZjc/hUH; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bprcjxUA; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fZjc/hUH";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bprcjxUA"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790539416; bh=nTZ5j6ad5AfeTmRJMTWImqn
	XR9Fm8cNjGi6bLGNXi94=; b=fZjc/hUHiYX9LAFOL2B3IzqeBf/NZOr7bF4jwsU4A7OrrahUrg
	/cfc1XyhXzDdx/1D7Xl33SBJwpCYPA5/NocbjBfXJ9uruVOhHK7iIfhQbsM+GoENGeS3aN8LobI
	6iu5awoGNhCBj9fValE531hMWK2TeUH4ecch3euKU0NxQr4Xl4AJfu1fjWMRkF0tsBa3XCvSFy2
	URexe8NZRQW1SzpYIQL44dcMraWE3L6XbWRKD/EC8oCIb1CimELYTjtGRDZy4B0lB0z/HgvAndr
	IN5Se1kCLjUIoYq9Jw+x9GmJlU05RqVwuUWKtorxIqCStsd11A3hy2fJVzXjjiEAo1A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790539416; bh=nTZ5j6ad5AfeTmRJMTWImqn
	XR9Fm8cNjGi6bLGNXi94=; b=bprcjxUA+EzOaG+D8Ea2H1hm5QmygqeZ90aEA3nehL+cP+qlBt
	H5HJTlm7HiHLv0WiQUxeoUtbEGRBptvMGnDg==;
Date: Sun, 27 Sep 2026 21:03:36 +0100
From: Bradley Morgan <brads@mainlining.org>
To: arnd@kernel.org
CC: arighi@nvidia.com, arnd@arndb.de, boqun@kernel.org, frederic@kernel.org,
 gustavold@gmail.com, jiangshanlai@gmail.com, joelagnelf@nvidia.com,
 josh@joshtriplett.org, kunwu.chan@gmail.com, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, tglx@kernel.org, tj@kernel.org, urezki@gmail.com,
 yphbchou0911@gmail.com
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
In-Reply-To: <20260925133922.1356404-1-arnd@kernel.org>
Message-ID: <CCDC929F-9556-4F8E-8B98-073F931F254B@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 25 September 2026 14:39:04 BST, Arnd Bergmann <arnd@kernel.org> wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>The added call to rt_mutex_owner() makes this fail to build in
>some configurations:
>
>In file included from kernel/rcu/tree.c:5121:
>kernel/rcu/tree_stall.h:333:8: error: call to undeclared function
>'rt_mutex_owner'; ISO C99 and later do not support implicit function
>declarations [-Wimplicit-function-declaration]
>  333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>      |                             ^
>kernel/rcu/tree_stall.h:333:48: error: comparison between pointer and
>integer ('int' and 'struct task_struct *')
>[-Werror,-Wpointer-integer-compare]
>  333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>      |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~
>In file included from kernel/rcu/tree.c:5124:
>In file included from kernel/rcu/tree_plugin.h:14:
>kernel/rcu/../locking/rtmutex_common.h:231:35: error: conflicting types
>for 'rt_mutex_owner'
>  231 | static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
>      |                                   ^
>kernel/rcu/tree_stall.h:333:8: note: previous implicit declaration is here
>  333 |                         if (rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t)
>      |                             ^
>
>There are already a couple of inclusions of "../locking/rtmutex_common.h",
>so assume this is safe to do here.
>
>Fixes: 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks "ok" 

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Perhaps Paul could suggest another alternative M

>---
>I wonder if it would be better to either move the rt_mutex_owner()
>definition into a global header like include/linux/rtmutex.h, or to
>move the code out of tree_stall.h into a .c file, as this feels like a
>layering violation.
>---
> kernel/rcu/tree_stall.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>index 5dded1e89197..803a56af3259 100644
>--- a/kernel/rcu/tree_stall.h
>+++ b/kernel/rcu/tree_stall.h
>@@ -12,6 +12,7 @@
> #include <linux/rcu_notifier.h>
> #include <linux/smp.h>
> #include <linux/rtmutex.h>
>+#include "../locking/rtmutex_common.h"
> 
> //////////////////////////////////////////////////////////////////////////////
> //
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
