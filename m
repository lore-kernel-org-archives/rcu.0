Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C94597A
	for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342574; cv=none; b=WXqxsIR0dRwI6tII9O4oRtIQNqfL4Sod1jVO9Fnv/99wZghGKsMqtgP20ERbZh5sDNDUH9EZqI0Ex0MRSd7CVceK0WHa7HQKSA5qa59nN+vYRc19g12FQwpa5TD5kKVDG+LRVoLTBWjHFCJCJ5BVQiq7Bk5Z8zPVb+RajkyKZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342574; c=relaxed/simple;
	bh=z/Z25UIEPd4XesS5jpsAI+gHLTNALvUUXb9vxxblowY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d73RpUvt7iO4KE88mv1U+Gn+x5r/i8xVjnnBFms/lnPyCyNKKk2tknZ9AVbQliGtoDqDjT8iftEZK/k0z+j/XUamzSF6ksDvvm25y7cI++r4LZgTP6Y+G9ziKUB8t3qbD4zq9QWWZ2u/53gJ9MModail3Q9YlzFLzxQzP+j6fpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Heaf8Scd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Heaf8Scd"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a54004e9fso46496567b3.3
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710342570; x=1710947370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiK1nnwokLzGpizwqoIOUJDEcuxjEjEOqPz6qD9AYqQ=;
        b=Heaf8ScdMiZ5Hiwx9eulvIo08u0xbT2zSz20o0K9KgK7y330n65dhU0/SgP4nPaEtg
         E9ovsfCaaqcAAaFRRKXqvHt9CJbI5qqAMf9I9NzaZYPdEVSkSZKJWUAM1YSAwgoPKNjI
         pHm+Hj/Tty1ypqiWIAREwCA+6W5mM3d1pvve2MxhKGip0tMJyKasp8Qs2b3AijR99r5+
         g52W8EdJ2at6xYMKvNeS6OsMWp+W48FeZmJvBHsr2UdcxyB9u95G8psqq/aabvkrOCjC
         Qw2q68l81cU8/jUjmYOT/FBpWGSiGHx27CKY0BLXZX/TSlu+IP2uGf0liGfDAhWQfyfi
         AjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710342570; x=1710947370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiK1nnwokLzGpizwqoIOUJDEcuxjEjEOqPz6qD9AYqQ=;
        b=eA5QMGyf1zvy0T7hsuqr9+u8IGdSYb5QHPgFAAnhfi5XNlWwvEupuCiWFUmad4Xb0P
         8b9PhrBtQ5JNZ01eoFx03N9DAQ0WrJoUzJ1BRAnoEMJHA1WM+ZDwao4HfVPs7d85cwTc
         JgTlkgdL3NffmJ6blkWWdEVMStpRfF+1xXxmv6D/PlX0rbKDBnwOi6dEWBG+ulS92AFI
         zZzbT1njvs/ZYcaTNKZf6pCrfP8pBPWUz4sPpHEtkdV9Fvkpv6nOiv3ZAJ6Wrwp0mwlX
         QMdDRyCcHGOs2oLl+wCOUGszUg3J+jAxNx6QCsoOP4Fdxz3LBEEHLLWjgeGtP1kbTgYq
         eE0g==
X-Forwarded-Encrypted: i=1; AJvYcCXY41RW/H+741qYAP3o2udHI9b4GwLW3CbFMVv8aQlqhj2wtOL5yJsyMX98oL9UUJEokWd0MaduJQLoPzCW9Rl2/QaK
X-Gm-Message-State: AOJu0YzeeITZy8vLWQGtzo/KErHCC/SfPD5PLxiabIfbJfy+RM61vDaC
	ZO9noKwjBvPV5MA6T7rfHId0Wpj45h+rFpjQWNAvCqCuzfhWGoCEn7oOPwcS7IZXp06HeNkh+TT
	+Yw==
X-Google-Smtp-Source: AGHT+IGY9jbJwt2sIbwHDebpTbc6rS9RQrbKdpk4Cuy3oeVMttN2tgAYGXjwAhCb1VWdz+Wc4ZOF8nb5Tu0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9251:0:b0:60c:b1d4:a9f9 with SMTP id
 j78-20020a819251000000b0060cb1d4a9f9mr333730ywg.10.1710342570551; Wed, 13 Mar
 2024 08:09:30 -0700 (PDT)
Date: Wed, 13 Mar 2024 08:09:28 -0700
In-Reply-To: <ZfFp6HtYSmO4Q6sW@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <Ze5bee/qJ41IESdk@yzhao56-desk.sh.intel.com> <Ze-hC8NozVbOQQIT@google.com>
 <BN9PR11MB527600EC915D668127B97E3C8C2B2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZfB9rzqOWmbaOeHd@google.com> <ZfD++pl/3pvyi0xD@yzhao56-desk.sh.intel.com>
 <BN9PR11MB527688657D92896F1B19C2F98C2A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZfFp6HtYSmO4Q6sW@yzhao56-desk.sh.intel.com>
Message-ID: <ZfHBqNzaoh36PXDn@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 13, 2024, Yan Zhao wrote:
> > We'll certain fix the security hole on CPUs w/ self-snoop. In this case
> > CPU accesses are guaranteed to be coherent and the vulnerability can
> > only be exposed via non-coherent DMA which is supposed to be fixed
> > by your coming series. 
> > 
> > But for old CPUs w/o self-snoop the hole can be exploited using either CPU
> > or non-coherent DMA once the guest PAT is honored. As long as nobody
> > is willing to actually fix the CPU path (is it possible?) I'm kind of convinced
> We can cook a patch to check CPU self-snoop and force WB in EPT even for
> non-coherent DMA if no self-snoop. Then back porting such a patch together
> with the IOMMU side mitigation for non-coherent DMA.

Please don't.  This is a "let sleeping dogs lie" situation.

  let sleeping dogs lie - avoid interfering in a situation that is currently
  causing no problems but might do so as a result of such interference.

Yes, there is technically a flaw, but we have zero evidence that anyone cares or
that it is actually problematic in practice.  On the other hand, any functional
change we make has a non-zero changes of breaking existing setups that have worked
for many years. 

> Otherwise, IOMMU side mitigation alone is meaningless for platforms of CPU of
> no self-snoop.
> 
> > by Sean that sustaining the old behavior is probably the best option...
> Yes, as long as we think exposing secuirty hole on those platforms is acceptable. 

Yes, I think it's acceptable.  Obviously not ideal, but given the alternatives,
I think it is a reasonable risk.

Being 100% secure is simply not possible.  Security is often about balancing the
risk/threat against the cost.  In this case, the risk is low (old hardware,
uncommon setup for untrusted guests, small window of opportunity, and limited
data exposure), whereas the cost is high (decent chance of breaking existing VMs).
