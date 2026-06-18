Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7C3E1729
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788305; cv=pass; b=m22hIi30NONxkUWh435a56OSWKP/EZhE9AQfz9HWmB+zQQ+8zCIc5OD787mU6uJt/JLsI0DLMz+0UT8eZgQ7BXkdjEb64qBCKCbSR6pVwpOcsD/Xb78ykZThNef9O80w+51ANzy0hNOycdRvGShdBErAf8VDwgUTJoAI01iURLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788305; c=relaxed/simple;
	bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSGI74D8Wdng/cy800pG5duy7OKGGDOEYbaJhcCh7bx9e4hcGC3yfUbVIfRm3BlWOCBEBiJ2LaVY4dgsDn9bZGT40p1G5KQ081y9JebR5UvCrmcsRPwCVgWbweDjjf99Da5YchmCLp2r+perfQ351OXRVFIIElo6ZGnDJ03kCmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=l7lBrjx/; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="l7lBrjx/"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88A303F85F
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 13:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781788299;
	bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=l7lBrjx/i4WZD1f4Wfxq71E84Mk5upv5cobBaRXhDUlFm7y6qHXwZy7DRfz8oJfSK
	 KI7degmeiyUGkduQJC+G2el2K2yUTdq9DP8qx8BaMaRgPahfgkmgS/9LmDGV4hCrwr
	 qgNuwcMqAtDucYs2wUOmGoZlYIQKtgNXSwTWOQtouvtDEQjhQERt+Da5NoYFPDJIjf
	 eE0+/wnVNnsXZBVbg7C/TjrM7wtBVs0g/egEnAOldxr1WboZjg3noItr6WGO7u56uS
	 t1UDo9n0sTQZjAElbRNS3w3fVwmIrd70BzioI5OD9Jk24SuoBM3yGeKWCLOky/iVoC
	 siEjw2MwFHZ5JoRhUefwiLDSYQnUUBuoddHieM5ZWl+qJh74xtqSxxkBVVJ00Wki2d
	 WyJ828StNI2NbPEvnxuLto7dKtxqhSTlXYWMTLBgAMfJxllxACcvYPT5eo0O0Ey0v/
	 iGiH71OW+YkCbAo8kxi0pIWmJa8UdGuMe4ZvIFGvqCqMzWPBY9HN53R/+sYOSZ6fCl
	 ibqanGkJxFb2ihN6MR6XuKVzD5s6AR6h4DETyiI/s4S/WZWoP1N2DmNvw8H8RgiUaW
	 T1AHO4aq5WT2kR/vmsSnKgVo+mtT0sE3cdMUvha5LxZg4wXkwpzr1XFJfKBxHtLXIb
	 TqPsm1ri7AFoAUAsgGmjuDmM=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c04a3ebafd2so95307266b.3
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 06:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788299; cv=none;
        d=google.com; s=arc-20240605;
        b=CCycQ0dZ/NjCTBL2ONuz3fPrCKkSwhfmANpx4VGtNpUNy1cRfR48H0R3w3oyGFOsC1
         s9FUvCtXFtmQ1Hmd2v2OMdK5/d9JQPiugtOh9Vc4GUnzNrV/qytNLOA8sROdc3FU0v1A
         TZzrAdgB+Q58u6Lyb3N8qqdrIhW4d8AOaw/N7ktmrmR+ovAVkw6Bn7SXj/rVeEXOj/et
         FI9sL2l26C+82JVZ53zJai/OXoIMAkF0HxtLW+a7KNo9rRNRFR+fUT8K7lZ+8lPcZYoD
         It6f+HgqAIDFRTORcumH6ksnTqIHO5kYo7XB6e3HTOZOOm1mQXKtg57aM2lYgXnTKyVL
         xzqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version;
        bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
        fh=rNJQqfssN5gThYivpsPN3Ja8+GkdGdYMyweFLXBSsfI=;
        b=HcVw33vWCa5xs71NNASzF02VtEnt2coz7LCPioN9qODE//hh4r99E5G/Aq9SzypDER
         diX8PviwuyJ6x0a7WzWlwZ7w/VnAhOr8G5NnH9pDGvvLanHE2x81sHBP6Af/lo1j7qAX
         VYVc+ER8aJ4VgAFysYA3IR4H6d6ELaHKUhJ6sRKYESzJZWyHlGvCQ6gxYfQ3YmOMlvQX
         7qoqW2gc29FQKORP/Xx2ciaFWx75mmtw6nCrofQTG67rz+ruiTZGEmMpSNxLtzbwgVSI
         so9TqotLFLt5mNCVX9kJzxMOFPDC8J9g42I2gJEiBnDclFKsbBcgnZP1l98o6TI/Sj6Y
         CubA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788299; x=1782393099;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikyt66TMlNKpG3woAwTQOhNuC+F7tCqH5WhDe9sQD5w=;
        b=L2UjpHxU+V31hQeVu/ksxKKDOvfyO7M6AREqI8tS6GczsTh29Uom9iHejBJf4jwUi9
         iZDUiioU4IjtHbP/mMDhHq/tDcRMPHcqLsUXFjHCXXIWofdJri3IPD/zZY6g9Gn3dqPx
         wNLgVUr7j90SYqA/3YuU2OFgVBxfYG6pLQxN9iv3NMpdctwuS+5+ShE+7DD0wSOcyh1t
         NUG6UpszlQiP4fH1F6icq9KuLt1E0Tzp1m748ZBvKgHSeh7IR714L6hUs70OT1lKkJL+
         T3Wgx+oZfMFmTKrGFmymZTDkpEfG+ltpe6G7q8c83fRKqZH3egJK+vLkVbTGQRGaVumC
         6XqA==
X-Forwarded-Encrypted: i=1; AFNElJ9oOl0Ew+KRfH3YpWZspXo6jE5fWboEJ6p/qSxmShVAuHZbfMKPkU1Zn6ni7i1DCIbbc5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIomDTcWXH1nKAlcb9q1DRwLcJr8r5TJ+bRyq43No6mpemP/P
	/BWf3A0pnpWue4hFv0fjmXy5qYhRjBCrBIulWboG4e2nkUIa8Gc2vAfWjoTpA/YmMXDOBCG5ppE
	U15XurOAHsiki+RyOlAoP2scLHeZWIrqiZ9pXCDaqNSH2sp8CXeeNiq5BHouoyGBvefMH27Cw/p
	EIedED0HTtlJwKIkzD9/VB7SNGPrw+nKmhxs+akDaN2YQz
X-Gm-Gg: Acq92OEworKLLgYKq+OYfjLl92v6rhDe1VGbN0ONLhGv3AbtnU4evMRQopB2mUEOK/N
	soYsxpWiPHr1L2PVhjApUu9odnJKCAMOPdKe+uKCemh14hxoTO2yMJzbaZ1A0l33J7S4qTYS0Up
	+GWdEBZf0FADIng6WSiDMRbpyCwpKtAxmrvmARusULNu1DTBjDaUrBkl0yOt76axrqpQ==
X-Received: by 2002:a17:906:cc47:b0:bec:e6ae:2f69 with SMTP id a640c23a62f3a-c05a4720184mr330889266b.30.1781788299096;
        Thu, 18 Jun 2026 06:11:39 -0700 (PDT)
X-Received: by 2002:a17:906:cc47:b0:bec:e6ae:2f69 with SMTP id
 a640c23a62f3a-c05a4720184mr330886266b.30.1781788298585; Thu, 18 Jun 2026
 06:11:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 08:11:36 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 18 Jun 2026 08:11:36 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260320222916.19987-1-boqun@kernel.org>
References: <ab2yd35rm6OgZUmb@gpd4> <20260320222916.19987-1-boqun@kernel.org>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Thu, 18 Jun 2026 08:11:36 -0500
X-Gm-Features: AVVi8CdNkaVYBWAhyDgLK0vLSd4h3zxECQx9FcmqMplPRvrgTirU1SNRffTdnLU
Message-ID: <CAJM55Z-hiNDuu5UwoBe7m0wq+_WJrRY0cwopALUgpG+r3ixj8g@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Use an intermediate irq_work to start process_srcu()
To: Boqun Feng <boqun@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, frederic@kernel.org, 
	neeraj.iitr10@gmail.com, urezki@gmail.com, boqun.feng@gmail.com, 
	rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	Zqiang <qiang.zhang@linux.dev>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Quoting Boqun Feng (2026-03-20 23:29:16)
> Since commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms
> of SRCU-fast") we switched to SRCU in BPF. However as BPF instrument can
> happen basically everywhere (including where a scheduler lock is held),
> call_srcu() now needs to avoid acquiring scheduler lock because
> otherwise it could cause deadlock [1]. Fix this by following what the
> previous RCU Tasks Trace did: using an irq_work to delay the queuing of
> the work to start process_srcu().
>
> [boqun: Apply Joel's feedback]
> [boqun: Apply Andrea's test feedback]
>
> Reported-by: Andrea Righi <arighi@nvidia.com>
> Closes: https://lore.kernel.org/all/abjzvz_tL_siV17s@gpd4/
> Fixes: commit c27cea4416a3 ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")
> Link: https://lore.kernel.org/rcu/3c4c5a29-24ea-492d-aeee-e0d9605b4183@nvidia.com/ [1]
> Suggested-by: Zqiang <qiang.zhang@linux.dev>
> Tested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

Thanks for the patch, which is now upstream as
7c405fb3279b ("rcu: Use an intermediate irq_work to start process_srcu()")

Unfortunately it seems to halt booting on the Allwinner D1 single-core RISC-V
SoC both on the 7.0 and 7.1 kernels:

https://esmil.dk/d1-7.0.txt
https://esmil.dk/d1-7.1.txt

Reverting this patch seems to fix the issue although it then breaks when loading
modules which is can be fixed by reverting:
d6e152d905bd ("clockevents: Prevent timer interrupt starvation")

This might be a side-effect of reverting this patch though.

We'd really like to continue support for this SoC on the 7.0 kernel, but since
this patch is a bugfix just shippping the revert doesn't sound appealing.
So some guidance would be much appreciated, thanks!

/Emil
