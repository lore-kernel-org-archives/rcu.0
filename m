Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73AE387572
	for <rcu@vger.kernel.org>; Fri, 13 Mar 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773391939; cv=none; b=CooLZSg41UK0kBquLpDerlDzBVvlaW7j/SpNMORU7ASWxFoupgWAAdpbA5w3uPh4lZIBaanUqzn2Q+JoqXLs7n9zc7bohXfTtR8lgzEErj2V7CaMhz7T6sMZbCI6oTfQxw694tYwKlrBSVWeZ3r8SFcuUD8GRjut7M8fXZmXBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773391939; c=relaxed/simple;
	bh=1bwSc1PZlKyfqRjwSO2HIGtOWH6cT3fS9MR0Ww4cYe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljy0ck0yFjofd00sPIdmqiFB+j39YLDN92f3oXwCveWStu67MKIpxS77pZ/F2BN2CRgcxAYWKz8MFuBbJme9Je2Lmos7pC0g0Hx2l2jzq8040szG1ZgfkIkvbbXDHqg8D1l1kJUSVFNCnYQswZulc04wMfWaBLUzMYbSiFLDMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/VCTHk+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/VCTHk+"
Message-ID: <067c53cc-b015-43c6-9ba3-c734eff17819@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773391932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CFKo+rnrKchenU2q+1YhqLq+XUBLGAtAgWsMVugHU4=;
	b=E/VCTHk+5Paf+IWcyyC30DhaFeiDzZ7QGkkIu7/Dj8c60Ej0sUe5aES5ulPbrayg9QtLyC
	ycAOdcOh3Rq/HRUkwz9HI/ijKHWbCjnTxnwrlkh/LCp37L7lJn9+cLeDvfiPt3uOWReQON
	YQ7f/ncktcBSuP5fSOuGcGcav/FgdGk=
Date: Fri, 13 Mar 2026 16:51:22 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/3] srcu: KVM: Add, export and use
 call_srcu_expedited()
To: Sean Christopherson <seanjc@google.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: rcu@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>
References: <20260309193059.2244645-1-seanjc@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20260309193059.2244645-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/10/26 03:30, Sean Christopherson wrote:
> We've got a conundrum in KVM where we have multiple use cases that generally
> want the same thing (eliminate waiting on guest configuration changes whenever
> possible), but use KVM uAPIs in slightly different ways and effectively create
> competing requirements.
> 
> The crux of the problem is that one use case wants KVM to free an object via
> call_srcu() so that the task doesn't risk getting stalled waiting for a grace
> period.  But for the other use case, using call_srcu() can trigger a
> non-expedited grace period and cause a synchronize_srcu_expedited() in a
> different ioctl (that must do a full sync, i.e. can't use call_srcu()) to stall
> waiting for the non-expedited grace period.
> 
> Tagged RFC because while having the call_srcu() request do an expedited grace
> period eliminates the unwanted synchronize_srcu_expedited() stalls, this feels
> like a very crude fix.   That said, I'm definitely not opposed to this being a
> final solution if it's the best option available.
> 
> Sean Christopherson (3):
>   srcu: Declare exported symbols before including srcu{tiny,tree}.h
>   srcu: Add and export call_srcu_expedited() to avoid transferring grace
>     periods

Hi,

Thanks for writing this up.

The scenario you describe looks plausible.

That said, the cover letter wording might be a bit stronger than
current SRCU behavior warrants. A later synchronize_srcu_expedited()
can attempt to expedite an in-flight grace period, but it cannot
avoid delay already incurred (for example, if the GP has already
gone to sleep).

More generally, before adding an exported call_srcu_expedited()
helper, should we consider improving existing in-flight promotion
or delay behavior, or otherwise making the "expedite current GP"
case more explicit without introducing a new callback-facing API?


Thanx, Kunwu

>   KVM: Expedite SRCU callbacks when freeing objects during I/O bus
>     registration
> 
>  include/linux/srcu.h     | 10 +++++-----
>  include/linux/srcutiny.h |  8 ++++++--
>  include/linux/srcutree.h |  2 ++
>  kernel/rcu/srcutree.c    |  7 +++++++
>  virt/kvm/kvm_main.c      |  2 +-
>  5 files changed, 21 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9

