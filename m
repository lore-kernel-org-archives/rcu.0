Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053D186E3D
	for <rcu@vger.kernel.org>; Tue,  3 Sep 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377467; cv=none; b=XcX5cx+M/RFM7mcizh/nS2N/w4RUgg06FyAbXyfdgK14HFG0VPRZcwo0W+6YlTfan0xf9s9oxJbu90O4/x+gDFuT5PgXsMH9TSxEzNB4jVMj8Nf9xu8NC5xYZOwK5X3uq8lpxDUN2Ar4LN3SlGVm6Q9djXlSpnuw8ljkAeNEarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377467; c=relaxed/simple;
	bh=myZhSHZglPxRmX1LeF9hNvw0WBoOmbw90VRio1gUy/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLUUzu4Hh+/U0oAyXJbB1DmdSglTrYT6S+nQD84bf+ikoxm3E3Nd8vJnQdLoJLCUHXjTEz+Te1mVK86aqA2vkz+mOVJnIIMx4S7Ra+vPTJwcCxe7XrSiB3pcMxlsCWWuFZJPkTNwGS8MUaQY7ILEMM7dOL7BPAd2FG6Hm5C4Ceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVr/BqKm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVr/BqKm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d52d811d1aso48053877b3.1
        for <rcu@vger.kernel.org>; Tue, 03 Sep 2024 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725377461; x=1725982261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ec7dmsuyq6MURvKN1Ek/X/vHghIhIMnPsF7++yal6w=;
        b=GVr/BqKmN+1FjYtqqdksxJxo8K3VG6iBCh5g+P7c1GolUYYGUE5mMN6lrLtOBO/tgn
         H3yBX30kH8cM+J5KUon5QiXNZ5NLcQSw6fdNPnPJiLGL5AobW27ieHK2s/86ngKQZ/e3
         HNTOTR40l2eAn/XVHuUg2YtvvcGKKDs6WwHOlhNJkRx9ACy/RfKypjhCgJOpRQVnOG5w
         KxmimPRoXgKx5L1iuQvGtBZWXE9KCNtKmZKq4n8fnNxyDLFYZUVF7BxSZIwjekgZ3BdL
         IDGnALM6fCMDHy7TBinurxpIMyPvGZ1L4MKWOAXzogvTZZNK2lQCkZG8rfg4xFwj81FN
         OXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725377461; x=1725982261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ec7dmsuyq6MURvKN1Ek/X/vHghIhIMnPsF7++yal6w=;
        b=g4NJEn5wDGpoTjMAoKCXlPahuYr3auVpARktoHoqqULATNbbcjFflCLZiPGbLhJE+7
         nYKrXIWAl1B/Cn7yv8k6kObd83rYdARwXKSZjVSVFDq4/R+jsJnxmWxfSjt5xsI91Qqf
         RTuGSt6eiGrOYpZLcD9kR7V0rC0S3ZYeBgRukQ3yZkhCB+oLbLP30dvcCi1a9PXhLCcM
         fPTmmFYEydW7NKllowZgagkD/5N4gWBtvNS7hqlAaAT8qWwwXQEWgZTw5Wy7ISGQHLSV
         EO9RDjXDls5DPGEvPsnV720SCCxJr89xx7KVz2qL+GIEa9yjDKYIubv+wRHCYftcCvJ7
         2amw==
X-Forwarded-Encrypted: i=1; AJvYcCWpEiteGUKRRq5fksnDbFUguxOkxf3R/BWTVEdyaCSC14lgcb74p0+5EZ8UXdLEW4F+kcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxjrHIy/dkM22g7bFGW9K66XUxxNM35JnlVI31FZ6oYxfFFwl
	DYQ+J9ixQnMUwtf8CII5mRUHsoQ3kaV/g3SbmwoB5xsZr1HaVSKdSAQNPz+1IyIfjzDjKHi7TKf
	nUw==
X-Google-Smtp-Source: AGHT+IEh9ne8KzfgecVZ/RaL9A4Ue6g6HIetOniUqznNH1pR9H+ZBj1JoJsiAHWXhWwmsoKvuOIyhj4bnjg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4d02:b0:6d9:d865:46c7 with SMTP id
 00721157ae682-6d9d86547dcmr1285427b3.2.1725377461550; Tue, 03 Sep 2024
 08:31:01 -0700 (PDT)
Date: Tue, 3 Sep 2024 08:30:59 -0700
In-Reply-To: <87jzfutmfc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com> <20240309010929.1403984-6-seanjc@google.com>
 <877cbyuzdn.fsf@redhat.com> <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com> <87jzfutmfc.fsf@redhat.com>
Message-ID: <Ztcrs2U8RrI3PCzM@google.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 02, 2024, Vitaly Kuznetsov wrote:
> FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
> but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
> Silver 4410Y".

Has this been reproduced on any other hardware besides SPR?  I.e. did we stumble
on another hardware issue?
