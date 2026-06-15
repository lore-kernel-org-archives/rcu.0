Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDDC3AEB2C
	for <rcu@vger.kernel.org>; Mon, 15 Jun 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553718; cv=none; b=r5TIeUWxTELbX9g3FKeWSvIz8gtUf/c1NF6E+vijrnIlUlKRpLOtbVNv6WX+Zy76KeUXmN+Kzi8w/EgjHG07JepLNTamFrmBIwtyTRNK4coJEI2OJjWbGW2g2HBlY2RBa2BM0fAAMm8gU7HWV9E6s2dXLfDalJl3pZjkdUhuCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553718; c=relaxed/simple;
	bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=utrl9XEhz352DS6jEAkMFRyavQ8NAo25lslq7Dr1EX1KKjs3uiPLxKXYJkTxLbebg9tqJ4MK4tSo5/gjPSXCdiIFgX09PVHsw3bRGPWeTmvOcqvIibABSh0JQwpdyxTxrntW7mFKRCRCkqXiYzl7Wz+u7nVes2pggBuvE75dAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REfJrHTI; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REfJrHTI"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e716b9e534so1897077a34.3
        for <rcu@vger.kernel.org>; Mon, 15 Jun 2026 13:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781553717; x=1782158517; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
        b=REfJrHTInBiVRv//3tKuAYZhJuYowOkkjM7C3kh11hlWYd4enPG0QSLMve9dcPQl20
         1xkE9nXQdVpbSiBGFdVXpCplJLS3fJwruL4KirS07InOJz87vrOE6mKjRvW/gtF6E68A
         58MIbcEIkz8Gr+55aFBJR+i7F8teH5DfAOSQZF+ZHa4TmjCpxd6GEudrmMsa9df3Ugar
         3iRoVQzSF/feot0dP9/SfdL61WX0XKDeHvshKzJ4cpXMVLJLViXRGVXwcD0xOP7TiM2S
         dwHQktxyNOM1G6FDtkzri9wNQ9zVBya/IrCzW8fVoHfWrhC9dMBtiE3TWa8xC7GypRJV
         x8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781553717; x=1782158517;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8wGM2SNC1ZbIykMA3lZWDIYfskaWmiv8ePp9cK/vJI=;
        b=NiAWCrnPIGSb3gnkwaATefYMBgeP7HsARosMAPB55yl4qlhU2X7kgMI1RPYNZ84Nq7
         w4HSDJEEk7NXCQU4WXrdqLN3X+H62B69COQ0afjNMgAzzaaWRZfw6dHcgampElu4J23L
         /BUdlMYAJXNfsYng4ywjqVaVYhaUHzj4JArslsvao8YtTMvaJla1zGs4f2tBjBs+N6zB
         wnGppBAJmOyFPqU82BUOLBRJ0OAEms2P0MHq+tWdxl+ko8h0rOy1MDiR+JeyBepFIBf9
         mxR8Jj/P0dIl0H9zLIpCAsqqBo+noNNvbRqHVcRuw5LqIIgfLe30AVSznQAtqWN582zt
         fqsw==
X-Forwarded-Encrypted: i=1; AFNElJ8G/xrjjQFkjAfv2qpSTpIlIQY6JKy6vtDNFNXf/dk4z9RPlJgnFtP6dWpF8c86kizsi7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPsuQJahIxGuwo1wqEiZ0+dZeEdAzrut0xnzkEVflEHM9xkV9
	zaFT42pG8lByO28nJ9j74TzeQZXcP82Js9jr61Hap1poQudyko2cfhdd
X-Gm-Gg: Acq92OFi8E1XZRcAD8UFD7pgJc+jnKFDiD6QE/p/GE9tFKHrA06A/cWrhWblY4xNtfY
	3UA4GBfAg4Jcx2zlWFelvW4cQVw2t+X1J8A1kUmnmjhV6oztMkEMG/aP9pmOSYAIZLP9Cbpez7i
	39cR3Uk6hwUHPWUG5sqJb+Pnfq36lRwUu2GGJJsH+gqJ058cle3R59g6WU6hPLQzkwShEn3n+pR
	uUoDnPpBV+AAjsHxB/RYBXql86ma+cGw+vgf9Hc6i6ilUftrm6YqArO8eL0Lf00LF2yxSsZjJBg
	3eAUHgxx9A2rQFFqXv4SBDee3IVSrfxruroGAPyg7qbSmE2J9rTAgYYyVESTwt7zcRrWCauh/xp
	TGLEYWBzb+cEwouOGJDd76IGb8FG6L+sAFtlCxl6YyG0o453HoRp9OpsSiV5RRzQsBk9a7rVsYh
	U3zY6Ps+eBoPvuOq9FvvbRSh76c0714pu0jh8nSpo8Na/NRO8TXZf+hZ7W9Ad5uWvsg/4KAS003
	rS6FxPCZUT71orLEk0xsRwZ/4E=
X-Received: by 2002:a05:6830:d11:b0:7e6:d542:aa with SMTP id 46e09a7af769-7e8fc512f82mr716552a34.23.1781553716566;
        Mon, 15 Jun 2026 13:01:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f6b8624sm4773335a34.16.2026.06.15.13.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:01:54 -0700
Message-Id: <DJ9W31UCKPW5.R2LKIC72ZQ68@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 1/9] slub_kunit: fall back to SW perf events
 when HW PMU is not available
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
 <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-1-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> slub_kunit uses hardware perf events to invoke _nolock() APIs from NMI
> context. However, creating a HW perf event fails when there is no
> hardware PMU, or when running in a virtualized environment without a
> virtual PMU configured.
>
> Since tests are often performed in virtualized environments, fall back
> to a SW perf event so that the test can still run, even if it cannot
> cover IRQ-disabled sections.

Frankly, I wouldn't bother with this fallback, since it completely misses
irq disabled section which is the one to test with *_nolock().
VMs need to configured properly. Even nested VMs support
PERF_COUNT_HW_CPU_CYCLES.

Also in overflow_handler_test_nolock()
I would add
even->hw.interrupts =3D 0;
to the end to make sure it actually stress tests things.
Without it NMIs are not firing quickly enough.

