Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468969;
	b=wtHnXY68zrM3bM00J/Dg9YSFlWdtIKP/el1ZRT85xRv+6xkkqwS+e1a758EYXqurQG7Q
	 YGP+xpZMYXsyTN8ABcJnNod8vsJrFeaNq5b0455o6fH6sHhXKE5MfQsj938GjylTR8f0y
	 Z1JiD6UCF0niVy7RVSZAv5JSCubD0rner3da+3Qr7MeGmyab9AXQf9ahXMSoO087YE4vx
	 AXLRYGEeMskfY7IInP8uVZkn1tglLucCkf3Ns3n8CzEkPR6gdtye1PgNn0UkE/53XesfX
	 Xy1updGA8SrRi3zbSiBw9HHyFhWmlucrHeFSR2+IkYTFj/BLDSAPRrU2tzztkRZyF+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468969;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eU+6TDE9yV82imn9cftyUyCCED7xbfUv9FoTzNU9AxQ=;
	b=e3Yc2GZkUC4hl+pSg3dRYaxVPIA8DlSYHwlgSSAPPK85BR2QidtH82/vu3jTlLByWc5K
	 hh6xloseUylXfmadtVj4O1UBzgY386RXEGtPxMGeFWSetu3ux5awDHFNeHX/FjfQIvU2h
	 u/xfEOBsRuL7wSv/BdWEoCX5N+Vb4AwxnwqNliwg7vgGsa3x3gqitUd2a7194dgF2ZO9h
	 mzjseGvGf6kOJLZr6B04BAJ1KcFgLe49Ymi13LMcozBxkKmoSmQJDUb9cpXv6fb6GnrCU
	 XOxjFPveHfDmjlMs1m3axx8OQ9s+QtoGN58QJg12M/OiPDZ4HKtK8viHPKOSsuf/qgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXzdykSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADD606A327
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXzdykSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7600D1F000E0
	for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 21:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795468969;
	bh=eU+6TDE9yV82imn9cftyUyCCED7xbfUv9FoTzNU9AxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AXzdykSlrixB4Ol5/wwg5LVbxAPTVXT0ydB610Pgq4ImciJ5PIhsl/680uPtvZGc9
	 cejHShoviTPVdjoG3+p+4tkgDeIDWJvad/73fG1eXA063UDMPN2k/vBgrK5pkAzVXA
	 HRjdFT1Pb7N93/TJBYkm/LFKdtj+zURr1AqwI395pEC0+1IbHyo4hUqk1vlTfAUQf3
	 xUXCHaYFL8knlVLhmvHtlDuUExEblqY0e67oMfxj0CivH40qgApR90Vt3dM1PXt9GV
	 FA2IjnQd/1Yv9T8cVB9M197ijLgwhaPwXozGmxSnhrUFvRfcXYxj8WGhnQvYVWDMOl
	 NbD/TlN3JxK1Q==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9496400270fso355911285a.1
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 13:22:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFSmZs80EOCG094AHWc2Q8qCMX/rRjKj1HxnzotCHjgiHVzfuooU3BnZeLe2tFEWFtbKHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WilBzXXRCspM3WYMCJ9SKy/PEziBP4E6oEfTV5iQlP4fBjRVB
	Fl7vgGFc1uxzWJpiUMqMbHdBQv6tKTGAT8WqWWE4fy23CKQoX3iMmeGYd/1g2JKCq0Jto3/W57n
	J2sMp3lhEOdHeRhNKmNkGdPMN722XBQo=
X-Received: by 2002:a05:620a:29ce:b0:93e:d854:4b83 with SMTP id
 af79cd13be357-949ba9b3e16mr2296045385a.22.1795468968646; Mon, 23 Nov 2026
 13:22:48 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135200.4086519-1-max.kellermann@ionos.com> <20261123135200.4086519-3-max.kellermann@ionos.com>
In-Reply-To: <20261123135200.4086519-3-max.kellermann@ionos.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 24 Nov 2026 05:22:37 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y8Meart6rfQ1i1oAm4NoM6YpPx+s-jgdrqgf_VPrs10Q@mail.gmail.com>
X-Gm-Features: Aa3M54rk1a4eAkP-XOuFBhkZSsK_OaOxvXCeyMlLajAigxVYkkkbNjKxH6OqKJU
Message-ID: <CAGsJ_4y8Meart6rfQ1i1oAm4NoM6YpPx+s-jgdrqgf_VPrs10Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:52=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Preparation for the following patch that adds tail caching.
>
> For simplicity, hlist_nulls_del_init_rcu() is now always used, which
> is also valid during rotation, because the entry is immediately
> reinserted under `memcg_lru.lock`.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

It looks like you missed collecting the tags[1] again:

Reviewed-by: Barry Song <baohua@kernel.org>

In the future, you can use `b4 am` to collect the tags automatically.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4wit5jKGn4L-NDTqzxDRNS8s8-FV3g0m=
5e6BOcG2Gx2Eg@mail.gmail.com/
