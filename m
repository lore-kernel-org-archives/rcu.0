Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32913630B9
	for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811867; cv=none; b=OZm5lVyrhd+vO/Tbwsvj+8vD9/5sKdtxQCTX++SR5cYbn0j/gUfZUapwXrEREP3/3VklyE/MXOPpA1cBnYM54AfbDma+rbyUh9CnWW2hmEjlczszvTJrjXmm8oHHg6VwEwDbSTCnGJtthA/W9v1Bnp81SGgr0BI9Ld6U6JD9jnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811867; c=relaxed/simple;
	bh=228mfLAFQ3GXHLkT80UKFb5GQ8lHGJIsTTdZABxXJ8s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WvY/9IDBSGwBZC8/D4GZhv5gUjtQm5pXEqQPk7QDKIN1aRuU9WBY3xGdwXKPSuPCbIq0HlkN9lpKF8Et3wIuIjGc/1ALzajU23yqKQ3x++gSQOogXWhqwHYFVir2sWshDkQ7/De1V9dy1a0+VqXJZV1Y6QNvTQ0z1q8jA7JAYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk0cOBDJ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk0cOBDJ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcd9061b1aso1092100a34.2
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776811865; x=1777416665; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=228mfLAFQ3GXHLkT80UKFb5GQ8lHGJIsTTdZABxXJ8s=;
        b=Xk0cOBDJG8lrZwdUj5W6YBmHJBMsZHyqIKLw4L2TCF7vHNjLl9H0pKa3juEu5efvhc
         I+31hUZ+ceAcGaHpysBmHBBlqZexDF+bo4Uxi0hxrdzOxL6YbOuwVn8ylVEltRXMgyMY
         7K2D739jAkvVP4EuG3T0Kmr80vQfnPCxbMgNzaWqWKWVY0N2zwKfbzxAKsEHqp6XiEym
         BahMkPFvOokxlR6hPjx8wTDvROcWvyB59yIAP5epPCIPBrIF7h3sEGiWLynEEyACgfMN
         /EEJ4PHtNSn9WPXcX2gc29azIBWVAGe5GuyqALr4MvyUmeCYmPO3PnXP1YUmxrRpmau4
         bugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776811865; x=1777416665;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=228mfLAFQ3GXHLkT80UKFb5GQ8lHGJIsTTdZABxXJ8s=;
        b=MWOrTyVKolscYERljNmTyr2A2aXJ5BRr49RwCBIagQJ0J+ZcGvBqLA8ClclYr5caTz
         GJo4gtqUI7rZJnrRa7+zehq107t/4t7smoBN49tKkmLvaaG6zvSbQhAry36MNBoNYU0A
         o83Gvt7e8BuHz+3Bw4KQRbxEdoISh9BaEqSaZJ24GFkczcrvyJnO7GN+APPSzqSExj0N
         /0p5vU2XUklo2cPR88FtJ9I8F0a74bTGr5TlQTdr7i7zhvWqEHYbE9cOJGhuw4NQNhry
         1C1rQqL2NiyuY8qfAAjwg5YSbz2ZhPM0/GeRzbCKtmiFWIXSGmfiPxtNrGzux3rlYTfY
         nDgg==
X-Forwarded-Encrypted: i=1; AFNElJ/ApfzjhGOO7PqCzjYynNkG/kNkFlN0WPGcoogjxYaEnoNRgdhqvpmn5Y65Dgl5ml9cHjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd37mkregkt1L14kRX+BO7D+tCDOLBiwCw2Zezk75iJw5GAwDc
	+3rHChPeruKHQO0R99hsCTJRlfsITs6GsnxPzA9p8j+BfyQWrERwsBlo
X-Gm-Gg: AeBDievqRwpxP/SXCu71nXJnw0u/f0QPsz7qd2eIVSH4HI7MgZcqg2GxopG4dX8nXVM
	L/Ptb3Ohqz3tqtImB6GySSrgdWyRx91iCs/lNK0Bx2bQyaRAvHNhfrxmN26T0c6+ktFqckUGizM
	+urJ6ZUJwhj6NNT3mSdrrK7QkeVoWvgA9XBCoYG2IJiigVuwdtiGYgeL7xRHifQgtnsUavZdCjf
	jpWhtZ3fMJ4fWYkcYSqQO7tzUZP/75IYxGViv4f0flaqDFYIcSkjrhUSVP50+GpPBTlS5xq0YWe
	vM0h0uKpey3DvqAJZCwQc6qUJg6ZJXYlpe9ve0xRLEAo8/UTeIsI1m5NTDuUGuBUvfqcGGlbgZf
	yLHUqNf74JxLtpmsaTpfhIGZP+r5obZcaT5noouE3f79wT3tn/bsjvzHpqXiTseDA8pRFDarWqc
	bTZeNdA2DzBMdpYNiMg90sPRKDbn9cWigyVZJNaAbKlL5egK4cyeFrPlzq9rhQkivr+jietakDx
	54R+gDbZnVmKKhow2Ireb7/XAI+
X-Received: by 2002:a05:6830:67f6:b0:7d7:5559:3d1c with SMTP id 46e09a7af769-7dc94f961d0mr12841177a34.1.1776811864782;
        Tue, 21 Apr 2026 15:51:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dccfe912edsm4252662a34.16.2026.04.21.15.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 15:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 15:51:02 -0700
Message-Id: <DHZ78L9HZ1YE.JY63DXXMN9NF@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>
Cc: "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Hao
 Li" <hao.li@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>,
 "Zqiang" <qiang.zhang@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, <rcu@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 7/8] mm/slab: introduce deferred submission of rcu
 sheaves
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-8-harry@kernel.org>
In-Reply-To: <20260416091022.36823-8-harry@kernel.org>

On Thu Apr 16, 2026 at 2:10 AM PDT, Harry Yoo (Oracle) wrote:
> Instead of falling back when the rcu sheaf becomes full, implement
> deferred submission of rcu sheaves. If kfree_rcu_sheaf() is invoked
> by kfree_rcu_nolock() (!allow_spin) and IRQs are disabled, the CPU might
> be in the middle of call_rcu() and thus defer call_rcu() with irq_work.
>
> Submit all deferred RCU sheaves to call_rcu() before calling
> rcu_barrier() to ensure the promise of kvfree_rcu_barrier().
>
> An alternative approach could be to implement this in the RCU subsystem,
> tracking if it's safe to call call_rcu() and allowing falling back to
> deferred call_rcu() at the cost of more expensive rcu_barrier() calls.

Yeah. call_rcu_nolock() will be really handy here and in other places.

When you respin pls pick some tree that sashiko knows about.
So it can apply it all and review it all.
Currently it reviewed only patch 1 and failed to apply the most interesting=
 4+
https://sashiko.dev/#/patchset/20260416091022.36823-1-harry%40kernel.org
