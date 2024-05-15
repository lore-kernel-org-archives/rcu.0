Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A526739FD4
	for <rcu@vger.kernel.org>; Wed, 15 May 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794359; cv=none; b=B5DptbzRzRUkaLojcDrxMFR198/bBNDRzQUDquRTPTktAB7BvEVJHyBlt82sbWty6fEIMfFvdXVtbhS0tSxuexkv4wQ7vkk7WLG7JvO9diqq192VUu8V5Ux0KsdzCRXqOuPdwItQI2fZHRRsG8wC3KVkRvp0mqwRYLLs8QvaGYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794359; c=relaxed/simple;
	bh=kiBu9aDX7EL9QTt1G+6SJu1okG8LZwH7rPudLYo5UBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MM8uSNjv2MBPV2gQwLEUX0YcvfPytVuxj2qInJWWr/X/y79zzJHHpD2NSGY1ueV//QBcgrWGJOoHqq89xNWusnHfXF47A4edZCZfMM4wql5EJaMML6viLjQHo1rYQTUh1Y11TBOhbhTpgsfCzXiX/8CrfNOcpmv2Dgh66CxjJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbBoxTwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbBoxTwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715794356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K3zrJi+7L7SmSVpO4sJC/EifqPPPG8oHimbPsdQiY8I=;
	b=bbBoxTwNkQODPyNB6oWzrpLhzzWJ0WvS+9hzrtY+aaITC2TfKM3cpMIwIRBwvlWkp5kHGT
	ZzqG/LS3+XfXRunmWhArAanpEflkeO/k9GaDDIUP4dOikE8vxqItVM54AjjZqR/yD8FMYq
	6IV7A4HeROYA9zFOqQwA8laouV2G2bM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-orIRuqGeM9S7b_Q2diYy0g-1; Wed, 15 May 2024 13:32:35 -0400
X-MC-Unique: orIRuqGeM9S7b_Q2diYy0g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792e34d2884so284199585a.0
        for <rcu@vger.kernel.org>; Wed, 15 May 2024 10:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794354; x=1716399154;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3zrJi+7L7SmSVpO4sJC/EifqPPPG8oHimbPsdQiY8I=;
        b=LCImXexead/etx8RUNf7ZdSRWaz0/PcCGfQAl81P58a+86boCIpdiTiJS7ub08U7ve
         AxgUhQ1BMJilBFFeXF5Q2K5U4MReZunxBVl0fd6xkKHQU0SHQedwpdVf5VpT8SCmP9kx
         ACUw/buY/YjINlTNfWzlNoGfh/sOlkm136PKFgH7Y3OplR5PZpnVy8WrRi83F1w3ddgC
         o/oXAdWeJuxbHQbkVR+u+fuTOYEDzPILq8Ase16Go7/8rsubLNOBDeGGJJ/bF0owNKm7
         UgiwcCbow+OyTNaZRzPH2rfeH/buFuHq/AaVxv+dd6CZf18hAfPeDy/eaFJdBpexCo3C
         tuIw==
X-Forwarded-Encrypted: i=1; AJvYcCVHJixFAIBO0X2WvSQ8RIYDupamt3/6OmDsakOqKLwyUz6STkR/RWhgLlMz8qy4yAIjnW4rjbd+Z+l7JArUifzxS0wX
X-Gm-Message-State: AOJu0YyMxKcJOxyQj7eh+SPAVqiVA3CTQGFRRCmOjIKygX+sM4z7B0ny
	IqR5oRYPvVWOmxWNqI0JVgCL1V67y1dKm9zzR1Rp3vp/uQ8az61aNBivjxFjfqXLE71yIq3WZAK
	v/EKvmix8o4nCxhIuYVEUOZMPWXOy+5SfTflp8U3VrQ3BnKmz8rk2oHpIulZHIgVZ6eASfj83s8
	D4B3VXXGA5JASlB9hi9uKdSIZ1hHVxDraOwQ==
X-Received: by 2002:a05:620a:4946:b0:790:e6bf:23c8 with SMTP id af79cd13be357-792c757421bmr1697143285a.15.1715794354171;
        Wed, 15 May 2024 10:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhuFXJCFrAqP1KpGavlBwSPWZKTHyKGVO9HIx7RJlDer6r8nEi85JyvPgFGo7LrS4jndsTSg==
X-Received: by 2002:a05:620a:4946:b0:790:e6bf:23c8 with SMTP id af79cd13be357-792c757421bmr1697139985a.15.1715794353706;
        Wed, 15 May 2024 10:32:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27f99dsm703976085a.37.2024.05.15.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:32:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/6] rcu: Remove several redundant memory barriers
In-Reply-To: <20240515125332.9306-1-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
Date: Wed, 15 May 2024 19:32:30 +0200
Message-ID: <xhsmhjzjvgevl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> Reviewing Valentin's patchset made me stare at some memory barriers
> on the way.

Sorry not sorry? :-)

> Here is some removal proposal. Some may be beneficial on
> runtime (fqs snapshot with potentially as many smp_mb() as the number
> of online CPUs for each GP). Some happen on more rare path. In any
> case they clarify code reviews so we don't stumble upon mysterious
> barriers.
>
> Thanks.
>
> Frederic Weisbecker (6):
>   rcu: Remove full ordering on second EQS snapshot
>   rcu: Remove superfluous full memory barrier upon first EQS snapshot
>   rcu/exp: Remove superfluous full memory barrier upon first EQS
>     snapshot
>   rcu: Remove full memory barrier on boot time eqs sanity check
>   rcu: Remove full memory barrier on RCU stall printout
>   rcu/exp: Remove redundant full memory barrier at the end of GP
>
>  .../Tree-RCU-Memory-Ordering.rst              |  6 +++---
>  kernel/rcu/tree.c                             | 21 +++++++------------
>  kernel/rcu/tree_exp.h                         | 16 +++++++++++---
>  kernel/rcu/tree_stall.h                       |  4 ++--
>  4 files changed, 26 insertions(+), 21 deletions(-)
>
> --
> 2.44.0

