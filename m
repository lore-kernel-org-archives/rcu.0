Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF76215F5F;
	Mon, 17 Feb 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804863; cv=none; b=aGJDim67ONiInAXwWGQGDLioWJcYuzHdioGWB9ilfbUaBA7ScMCNYJa2QSvaOKoKJMMMI5BWqx00EG0MeizWPTylXJFsosBZPdTL/F6hm5OUar2JlNGy5MqOn35RWJxtXxJvGfuqPTUt01V6/u5u1nbIgBL/jI70LsRzCT8yoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804863; c=relaxed/simple;
	bh=8ZiN31LP5BVgq89nMTLaROYbbv/RwwT44ovHsNPvNpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUN1W2ToWAdgNgCTV5Eln3kAdoW45l4gQIy3ioM8zAwdlWPMjtj2+F6ndE8892huq/br+h3bGkJSyqyG1Qw2217kWXfp6rGjgq0sIKY++zIUozElUpnXDU1omav81H6UjZe/m6T4W6KXKOn2l/D2wE+tKvzNOFRRMlAZvkqMAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTqp06vg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBeGTy0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTqp06vg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBeGTy0X"
Date: Mon, 17 Feb 2025 16:07:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739804860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knv1vu5PAfwQiS1RIXnJO+yB8gCyXMieOHUw7GMHhYI=;
	b=bTqp06vgOJhrCoOy/QMoKKBr0pfrH3J6lmAYhCoHggTSBY4k7jRQPoE4rhiuohKl3syYDk
	Y8ZrDo0fkNO03XBZmguRU0xeq2N2O3aP1CguVcPRz88ixLvV45wCoAUcAysqVxQSQYe9fQ
	uxqvOOlreVYP99lw60NSVksIooHY6A2hHAGj2miXDoLmsiZVERyKsyQPVavcn24lGvFTul
	fmIVhd1FpXlGNYsKSRQGrpef4e8nk8ru5ezKvymz3/AxgP5nGr/m4mQ7+GPM1qUc87C4c2
	OVCpL26f0gg/fktZE/kifX4j9NTWN4xM8GdFDDSTaKJaFdKBphQoExRxoicZ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739804860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knv1vu5PAfwQiS1RIXnJO+yB8gCyXMieOHUw7GMHhYI=;
	b=VBeGTy0XeqG45/4i3+DGubyOCuOPvbHpxGcVSn9zmbCKNCwgsHnz/pulSpR2ySjmZojqs9
	X3urzTzC73tygEDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	maple-tree@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH RFC v2 03/10] locking/local_lock: Introduce
 localtry_lock_t
Message-ID: <20250217150739.JyUlaKxI@linutronix.de>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>
 <20250217141956._01BcsrG@linutronix.de>
 <bbb29d35-0a7b-4b19-b0c4-5b2e899b7b5e@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbb29d35-0a7b-4b19-b0c4-5b2e899b7b5e@suse.cz>

On 2025-02-17 15:35:11 [+0100], Vlastimil Babka wrote:
> > spin_trylock() is not safe due to explicit locking in the underneath
> > rt_spin_trylock() implementation. Removing this explicit locking and
> > attempting only "trylock" is undesired due to PI implications.
> 
> Just to be sure, you're suggesting how to reword that sentence in the
> changelog to make it more precise right?

Yes, just a reword. Everything else is fine by me. It just feels odd ack
my own patch.

> Alexei will you incorporate that in your version?
> 
> >> Note there is no need to use local_inc for acquired variable,
> >> since it's a percpu variable with strict nesting scopes.
> >> 
> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Other than that, thank you two ;)
> 
> Thank you too :)
> 
> Do you agree with my fixups and addition here?
> https://lore.kernel.org/all/efc30cf9-8351-4889-8245-cc4a6893ebf4@suse.cz/

Yes, looks good.

Sebastian
