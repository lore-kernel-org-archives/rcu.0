Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57885211492;
	Fri, 21 Feb 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156714; cv=none; b=BpP2sWTBLyethRFcdHgPI1SxEYkYE/Irquj/NurGkpQwaVYJJ2Xk9VFk34BCous6EzCcvadQQygyCHpX08r9sLec/Drjggyi9In1GjfHOGV+HUC2bwwNB4t439n5yzs38fua6goaK6pE2oMuOZC1jhKYX9Nxzder6RGVPDaBQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156714; c=relaxed/simple;
	bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUBWw70IE+KTe+1FeJTXzbesCzXw+Cr+CFTUGPoTFAOs4Em89ywtJp2J0YhM9XXRRzE8r/TU0326KIeHsFUbsKB23sI4nTpD4bD7SkpOtS9qUzWvfjmJvhbn/8nrPZJvAcmBUxoDUSZ87CsKiHrdImn/hqtnNM2Q2UyWYOdjQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHDIpKSc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHDIpKSc"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so3555250a12.0;
        Fri, 21 Feb 2025 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740156710; x=1740761510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=;
        b=NHDIpKScwkiu1tRzTxQt+F8irxkFKyqv1P8cKI94lba1tEZa7t3NqvQuclxd/ggTsr
         /D8OBCwP0J0DFxIB1J7i4XyW20vCw7cJ8P8PyqvwwCns35fJN9YaRX7L6i4kk8RMf17t
         50dhJ+8iXv/rd6a20i5OnCV6p6t4VK174FFNF6VTTOs/PFcNKQPA2xdx3x8FQaeQLquQ
         bv/e1IteArY5dIDr85O91ZMNQh6ugl2m2AVp1Vnm+4nzhFiYR3LZToBHWHeNNah522vS
         N0VQ8dKLok5gLLvAHLuC8pObcXJCNt7uq7TFs0X1aOC3errP1VgWpa6U3XJ5g/CjhYJ3
         Ar8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740156710; x=1740761510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3GfVBZPNIG5qDKUks2BtPgtADXfzW3N1roYhgf4YM0=;
        b=c9hjn8P/PDuEcSa3L3qFqrWD4Ro1XAveZtEQvQtpw3uQDU2Q6I+qK0ImJQispii7Sy
         fv2PYB39IgOi/28Rhx+TRLmsv3cMYkCNtFvlCHboxojQ8p7rK8NogC0p4JhMGRKabz7W
         svjC5TtKH80KOdp3LOc/xSfp0yNhyG/mVCLIzZQnH/sloPeRMC7/edATzEp9eh7ZZngD
         F4RYy8NQPgTOAkTEQyOvjhWpO8kPk5jz91VfhBAOmYzDa+cVQSFkXftVdEoJV9oEHoq3
         rlBYjTVQCyYIOqkO22kebeE78ZvuDStzMQcrolw8T33aJT69HsNfx62MhEZYpjKnGtco
         GN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDd0Tlm3QFBpXwThUjtRacc3IstCAg5DJccfPVvZvO4kAm5uk1f0jqaXJRecnW6Jclmc40/wEPGdNwQP0=@vger.kernel.org, AJvYcCVRw03lfcjQ6/3OJsM9ovdUpMrO8M3KFlqplEs2pGl0k/PL6C3rfJhtQ8TtDmseu3nqau7i@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSlX1RlHFCRIMU4zfjSERT+kNOid5watTGrNqZmzmWlrAtNI/
	MFhqeqzU/iKBbnl+47149nTYga4slNYUR0mEHxVe5XmudbLjzQ6nkySQkyZudqDMZ1KckGEdO3l
	0yaUFKUmYFUoMoMp+wN9bRHYSRZk=
X-Gm-Gg: ASbGncto+J5qEfcs7YocQDAbYoFYOFMmLs++Wt2cqAHsVvj3Hx3lEAng2abOMkPzySx
	uyf5kXvFeE3YpwOOamW2PL5fwZPKy7F5OSeWFsvfW5nndslgmunfblm+hiQexDxrTdIsM239E0i
	G166MOow==
X-Google-Smtp-Source: AGHT+IH9RKxj/U5zpI3JA7hDcdGZ6v0ycbSRxZnemxlkZtExRwiejOddMUWgeNEe0/MCt6WbW7V94i7UPAID+ZQRr5A=
X-Received: by 2002:a05:6402:5246:b0:5de:dc08:9cc5 with SMTP id
 4fb4d7f45d1cf-5e0b70ccd99mr3708605a12.7.1740156710272; Fri, 21 Feb 2025
 08:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
 <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz> <Z7iqJtCjHKfo8Kho@kbusch-mbp>
In-Reply-To: <Z7iqJtCjHKfo8Kho@kbusch-mbp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 21 Feb 2025 17:51:37 +0100
X-Gm-Features: AWEUYZnfVYIJxHkGF1zZWtSz2bHpYaGIafeC21mOa_0SYKWj9c3lZDabKwAoH5U
Message-ID: <CAGudoHGF8ULGPEE5E6ZCTcVnm3qjY0BfT2DmBjKohW_rDK0JSw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
To: Keith Busch <kbusch@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Jakub Kicinski <kuba@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>, 
	linux-nvme@lists.infradead.org, leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 5:30=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
> This patch appears to be triggering a new warning in certain conditions
> when tearing down an nvme namespace's block device. Stack trace is at
> the end.
>
> The warning indicates that this shouldn't be called from a
> WQ_MEM_RECLAIM workqueue. This workqueue is responsible for bringing up
> and tearing down block devices, so this is a memory reclaim use AIUI.
> I'm a bit confused why we can't tear down a disk from within a memory
> reclaim workqueue. Is the recommended solution to simply remove the WQ
> flag when creating the workqueue?
>

This ends up calling into bioset_exit -> bio_put_slab -> kmem_cache_destroy

Sizes of the bio- slabs are off the beaten path, so it may be they
make sense to exist.

With the assumption that caches should be there, this can instead
invoke kmem_cache_destroy from a queue where it is safe to do it. This
is not supposed to be a frequent operation.
--=20
Mateusz Guzik <mjguzik gmail.com>
