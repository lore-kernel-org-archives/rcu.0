Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713794;
	b=FWfmCJ4GBNYCuQNNemsNqM/g9vVudbjXYM/HgJihtp9DbO6chSwZOoAxTShntlCpFuDV
	 9aecoT/jYl0e1+8an6Nku6nAjOOmVU+jciXgRbN/r95mTWezTVD+q2Zqvv+HPkJ+J44jt
	 lZy19qND+Z4zYFq68bes0kN6vkLQjSFK0ll2toNqG6o6jbRypl8aznZmkRr7iQhAn1BEs
	 73zCh20RRe1lQLSxdedZC5f3DIr9rUDxlQ6MBVUVsFNfHW9a0KK0+1QbDH3YSM/riQm6v
	 TchqT9RW5V9LXtuU8R5586jCLj/CeLVuuo6CbMghQvjt1oU0sBhqL77htOveVCaES4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bqR0RcC9v5qQRowJ7OkJmMT8g0ibCUrIqL4iY9KFnZA=;
	b=2FusQkWPK0P7bJFp+wWHMvq4OBvrVwK3aqzkPyD4+nny5NlCrLTuFG8quTkKkePY1cOg
	 DDdxe8iYN6G5riUZ0ZE2Tdqc3g5asbV+TeOLp1+1xfxnt6LmEXvLqs1EfuZsGvseQx4ns
	 fc8gU2+nf8/KUJvZQ3hOYtH60o9bS874PXBo+u6GZJw0nkDXlrLiyEh908ucJtj0FkKBc
	 jYndXdqCGWzpaKtS9D53tJ2VgdgeZ+qceohguzZqQn5uGd3/Nt5ZSExKzVMCSXdwz3fyH
	 S2DhARLmqNYPza9RZtwd5T79kmNubB2w+EYe+J4tzOdRaBiamBkvwUNK36wHplObEng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E3L+3dPb;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F8606A323
	for <rcu@vger.kernel.org>; Sun, 15 Nov 2026 03:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B7F8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chriswiseman.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=E3L+3dPb
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3407507eec.1
        for <rcu@vger.kernel.org>; Sat, 14 Nov 2026 19:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794713793; x=1795318593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqR0RcC9v5qQRowJ7OkJmMT8g0ibCUrIqL4iY9KFnZA=;
        b=E3L+3dPbIJSiv27ubSBF0gyvXUf48aR2N6ImxJxnZsMgcC40Ck2hVFrVZzk6/rKn79
         PikIBfYyJbBQBWXyxuhHGCH/etL8VkZOGeDbpZ+GYorTEiw8wLyVjKVrxAbtqlCoUJIr
         3iEOeXYP5UNqpd8EDxuy+t02Ue0FL054ka2q9YxdPZXVz2a+d7bxIIQGjUFoisu6Is6F
         2FuqIxp5Et+2RKIJCU9KX9jUKLnoD24idOv4zUckRr610e14r3zhN+m9H9z7Ff/GvQyJ
         VJfJc1yH/AwRhL8WO5HwoSZgNERXObaYE83nFqr4nLYWF1Kyyl58etCa26dCtjqTPcXU
         GKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794713793; x=1795318593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqR0RcC9v5qQRowJ7OkJmMT8g0ibCUrIqL4iY9KFnZA=;
        b=s14aDerjscRohbiwFUjmBetHeEUm0Nx8ynxGFkEQg81bWyrLsBi57yG2Vq8ifxM958
         ZKMQS1J9/1UCP2a1A+m4WF/jheoAiF9TlJXSBu6Ac5boW58npj6aXLZVWgyUxrBZAPuS
         cQrs/R+Wp7W92LyNREwrt8FgGbB0ozhSTBmPiBoD67gfidIMKqDg117dlYikC/bSU2ep
         guH3n8ln0aX0286MNxMbq8iAkbnUjX2X6frdhvhC86c/6pNImVFiPM55hZXjsmDamYlm
         dDUa972xsK5TcAenIdlPK1FQaq/St8X7i9dFxvWauterGK1FTNBG/ZxPIQAnJVzeR8C2
         CucA==
X-Forwarded-Encrypted: i=1; AL+hErFgAIkF93kRPVYnzlJ3cjqYRwFBoR8LJp00CY4MWd+4yaR/hM+XfK+sch9dmpD72z4AADw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/mCMhXwx0Oq2nURs6nnGbmjo0cUtHwlfEWLtKH5vYJZ0W4MEm
	vb8O3iYARob4p75M6m3NmqL26F/KJM5o712HowKQJqn+6p/uVx/avfcsTsPlH0ILrZ9hkoSVT2h
	dZI+L7XPNAMXGc2u0MGimE4pwUjkerQ==
X-Received: from dycne10.prod.google.com ([2002:a05:7301:c8a:b0:369:f864:c5e])
 (user=chriswiseman job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:b14:b0:37b:4a2b:81a with SMTP id 5a478bee46e88-37b4a3a4b7emr2845579eec.4.1794713792906;
 Sat, 14 Nov 2026 19:36:32 -0800 (PST)
Date: Sun, 15 Nov 2026 03:36:32 GMT
In-Reply-To: <20261115023115.GA3752240@joelbox>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <18e815d3ba49a353.3137322e32332e3235332e313736.192c60.0000sendgmr@google.com>
 <20261115023115.GA3752240@joelbox>
Message-ID: <18e81aaf93650e1b.3137322e32332e3235332e313736.231b55.0000sendgmr@google.com>
Subject: Re: [PATCH] rcu/nocb: Keep lazy timer intact on second lazy callback
From: Chris Wiseman <chriswiseman@google.com>
To: Joel Fernandes <jfern@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Boqun Feng <boqun@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>, Cheng-jui Wang <cheng-jui.wang@mediatek.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chris Wiseman <chriswiseman@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Joel,

> Looks reasonable to me. Is there a test case that you added to find this, or any
> power savings that you found with this added patch?

I spotted this while tracing idle rcuog wakeups with CONFIG_RCU_LAZY=y
and rcu_nocbs=all, where rcuog kept waking up after 1 jiffy whenever a
second CPU in the group queued a lazy callback.  I verified it with
rcutorture (NOCB01) and measured a light background callback workload on
an arm64 system:

                        Before          After           Delta
rcuog wakeups:          1,885           1,174           -37.7%
1-jiffy timer resets:     739               0          -100.0%
SoC power (CPU+DSU):   94.1 mW         76.5 mW          -18.6% (-17.5 mW)

Thanks,
Chris
