Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF91E526
	for <rcu@vger.kernel.org>; Sat,  9 Mar 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709946590; cv=none; b=ZWm+qrGDSkG4ecLxCNZEq1wrw+v8OxjDDWD0VpxFOv521chzhd+dQr3RYPaxKAf+7qni6PUl3jDzMX94086F1f2ErDwc6Ox3Nworo1I6c+x32iN0/QVfjfjrk5GUsPQBn8kUDJJFRuoS0YqIo9iQlpwSmu4E1NJeByS21yqIcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709946590; c=relaxed/simple;
	bh=j5KgXER4nINsShPo8aYOrG+wphwo2SK+yLSChO3NEJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cjpREVL+KyejGSFr1142N8qA3edBlr8Mc9UzW5wHIdk//jfVjAhdypdSLRWBlbo9b8jDl5MJGGGzRsGTREsF5co3oYE2uaDzH9YObhX/KF0Z1/ckXEL01qLyqqFxOk0V7Y+7hwJ42E+bJoXjH5IZDMudTqym3o+yirb71NCLwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sY2Wr5fp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY2Wr5fp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e5323e15f2so2818458b3a.3
        for <rcu@vger.kernel.org>; Fri, 08 Mar 2024 17:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709946588; x=1710551388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=opv/pkYi5ZzIQaSkE1dFeCV7eMElrF9Hr2aQKt+M0LM=;
        b=sY2Wr5fpg09RPtdj9bLKU8/33TfK9+4kvMkg+yjdPXkBUOAGFSFwROK/zC3s1MaL5z
         DccWlFXW+bv30XCRIJI3T9WwVUNzT/i4gEKDrIn3WiGvPqUx+Q/u0KrgIlFtkHD26/n+
         iBi2U1gxZD19BXWxqQYpCEYxA+CEnsthMty2FBd/yYK/0mWSfQ+AKDHlefDP1W1rEqta
         IL5+m2rzJE8VqEiY41Cuwrtv5CmmUaDeYD7cy3scFSI7cuIuREvtoAw6WNhrwlnNURT1
         jncNtTiLsnVh4uMa9LsptlRB+fePoL32YC2kMAs1yzfVi359kwFgktidNQAdgnr6O+9c
         z+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709946588; x=1710551388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opv/pkYi5ZzIQaSkE1dFeCV7eMElrF9Hr2aQKt+M0LM=;
        b=BYYiJFcRT44uCJ9MJsFY/AGB/unxGLNFNvBum23Dt6VKaVOV92rUHGFPAXzVrNFS5E
         hTmmcBb6Ay5oqdu7axGAlOOoncloiSnJjGOh9C7UdxunChwWIcYVY2A6xDZWvUHc+mvN
         qrAOArMoLtDZjlEtLHJFRw4I+lGqIZGzrusXWDBTCklt7Z3A/B7nYuLkqRz6wZCLQsBt
         ygFUYZdTmsWnW+wB3h1qJIAHtH1Fr8M/gTTKs/3FfQEQTAbgaexCCc5Kd1A3fYU6gtPh
         WHETELF4BwunSea9ywT0CYBgV/WbxUYpG1aIhFCOZnfapgYHuYA2KS5K6pLlSf7Z90Ru
         YEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdEvng/YHamFFUpfnhC1c9hM+00bLIQfWxKpQmjfarpHEj8mTmSvAEtA8A5nsRowso8yeB6eNkKwthcvMNCLt8e2EH
X-Gm-Message-State: AOJu0YzxVffAwQ6wUDb7hLtTwg/9DPoZ7a7br4BL4GMCJL5NaXMavo9D
	yopWme8lrupO9Tw4hmEIDYH6e6DoTw+kzfNyu12r7qs0EJ+K5k9zAuhs05N/tS08FOFzkynei+O
	lLA==
X-Google-Smtp-Source: AGHT+IEzPID2lPLBmutN4pY8hBZkktARYVaXQpGLwpt2q43XvRaJrXEizBq0sMzKUMMe8Z6+tvqhpC6gOYM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2291:b0:6e6:4f0a:422 with SMTP id
 f17-20020a056a00229100b006e64f0a0422mr38978pfe.6.1709946588027; Fri, 08 Mar
 2024 17:09:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Mar 2024 17:09:28 -0800
In-Reply-To: <20240309010929.1403984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309010929.1403984-5-seanjc@google.com>
Subject: [PATCH 4/5] KVM: x86: Ensure a full memory barrier is emitted in the
 VM-Exit path
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yan Zhao <yan.y.zhao@intel.com>

Ensure a full memory barrier is emitted in the VM-Exit path, as a full
barrier is required on Intel CPUs to evict WC buffers.  This will allow
unconditionally honoring guest PAT on Intel CPUs that support self-snoop.

As srcu_read_lock() is always called in the VM-Exit path and it internally
has a smp_mb(), call smp_mb__after_srcu_read_lock() to avoid adding a
second fence and make sure smp_mb() is called without dependency on
implementation details of srcu_read_lock().

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 276ae56dd888..69e815df1699 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11082,6 +11082,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	kvm_vcpu_srcu_read_lock(vcpu);
 
+	/*
+	 * Call this to ensure WC buffers in guest are evicted after each VM
+	 * Exit, so that the evicted WC writes can be snooped across all cpus
+	 */
+	smp_mb__after_srcu_read_lock();
+
 	/*
 	 * Profile KVM exit RIPs:
 	 */
-- 
2.44.0.278.ge034bb2e1d-goog

