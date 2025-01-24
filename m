Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63D18A93E
	for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750130; cv=none; b=kSCC7FtZh9ge61HGBnQvl/y89D6E7SA4uBraaf5OrCQq1ph5ScHEajPe/KxU987XUOznHFcjdOmchq2BZCHBRhUoz5HZMjkcB1yOkHRPUltJEl87rPjj3fJtKE90gqsFOGHZKoXEqSRUI2LGaAB8waZW2415zEpLHYLQ+gqLoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750130; c=relaxed/simple;
	bh=3ODZQWe1k25MiGid1qs2HdvzLWZpY7VSO7dMWfXR880=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDt28PZlNY0llKPlwiykCORultIS6I/6SagrZzqDhrVWJi2VPVRnmtOcHklq4+J4epwdV/1l1+GQ5Q5p6BGHEh5fN4grVqD+1cWE7kl34ScIZav291ci1WjZ/KnYZnZQEmZZkM3pO0Oqk9aOPsl1agaCB5/rgeHiZ6FVdjWrrh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=eEQHW4vo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eEQHW4vo"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1260402f8f.2
        for <rcu@vger.kernel.org>; Fri, 24 Jan 2025 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1737750127; x=1738354927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y56mWk83u2EybqH2/MymiukssPqGfepWnXsTwgXnMlY=;
        b=eEQHW4voiTlNv1i6CdL3mxpxr93cwxbPLoISThpWZppw7mQBLq/+ZDRYmIhrwyRQGI
         Q3JC9+3p0BbOkrOyQIrPVrgYeiauyXfhydj0EeEp/8T80/6/1GMP5UtlHtdx1Z/JY4qE
         6c8l7IGjohWjyNDGxbVEl10de7j4rJZwkfyAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737750127; x=1738354927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y56mWk83u2EybqH2/MymiukssPqGfepWnXsTwgXnMlY=;
        b=o4SZ+6lfpm606YDlDd6IMHrm7MB96pPeWuh6rg/Wk3DckxkIT3Kw5rTPIhPSDx8KbS
         4zJT/fjgavwA10Vg5jIeuRE6nNJmo0VIreZn06ApTbCPINhInA+Vr8X7N6k4p030zWjO
         XKqaSJlYIvOazkOiW2/Aw9Xx8nR4SeziZfPvrPwCgu9LXgatcJ3mE0fLGZKzYvbWDo+T
         9NFtopZKUc7+hCZ22SLMgKrb9Q+DgTMEFoGOdU5xtH+2Pn5EY0jClY3nZewo/rF7+JAi
         +LPEHneg1BZQDyt5TR8NXm2rvBngmw5GrqunVicBuHYg3Lprev2XPccEiCk/eeVHxNcb
         UfGg==
X-Forwarded-Encrypted: i=1; AJvYcCWxxykdAf98IgNenRSxQntQ4VlQa0rPzq5TpkNP7XnVdOOYUPhMjIxSIaaX9nsYVCR8o8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLpa0PDQsADpaDNh5tK+1w/JeJNQ9/hftjW0pq01YBw5AkGBP
	m7i6JNInF0sTq1F1UUZ1DPIbpZsyxDPVYeS+dLUfK2y7Ob6F0UY/1AZxFAzs3WO0t0XQaphvaDi
	iydBLJ4vfhEXjy0V/tSAkrgAwps9bDFrzuVpdwg==
X-Gm-Gg: ASbGnct29ptb5Qy0wi5r9aVqcT0e2DfStA7SS8sdBoB4GN3PugeNXtN34L/K2WMdUs8
	eCeELRvhAtUrOmf2pnk4YhED1ojSaSZUsWY6oPIyUqTGsJx6di7XWCoZWxohzG5A=
X-Google-Smtp-Source: AGHT+IFqNZGliQHPrdJfO5OorLd6KnSgZvMbMiO3xGlFpf+NaeCe1gAcWZz0tQ3YP+4cgnqNPJqUoKX3vP6XGQ1w5Do=
X-Received: by 2002:a05:6000:1548:b0:38b:e32a:10aa with SMTP id
 ffacd0b85a97d-38bf565521bmr27204957f8f.5.1737750127126; Fri, 24 Jan 2025
 12:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb83ab84-05b3-43da-bc59-e2dbd932740c@paulmck-laptop>
 <CAEXW_YSo1NTmx8FE3WNN7zL9so24o40HXhxubHJVvfxWBYtz0w@mail.gmail.com> <Z5OqE-eJDo-1W_-r@localhost.localdomain>
In-Reply-To: <Z5OqE-eJDo-1W_-r@localhost.localdomain>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 24 Jan 2025 15:21:53 -0500
X-Gm-Features: AWEUYZkfhOCyaCtX0MYay4e4IPOFr2fvGox1CUZyf4wiCptO107dpn_gci7377w
Message-ID: <CAEXW_YQSxGiLT8nPGRWm1v9+4X+N9+JpL+fq+hOH4BpSUCkcXQ@mail.gmail.com>
Subject: Re: [PATCH RFC rcu] Fix get_state_synchronize_rcu_full() GP-start detection
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:56=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Thu, Jan 23, 2025 at 08:49:47PM -0500, Joel Fernandes a =C3=A9crit :
> > On Thu, Dec 12, 2024 at 7:59=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_f=
ull()
> > > functions use the root rcu_node structure's ->gp_seq field to detect
> > > the beginnings and ends of grace periods, respectively.  This choice =
is
> > > necessary for the poll_state_synchronize_rcu_full() function because
> > > (give or take counter wrap), the following sequence is guaranteed not
> > > to trigger:
> > >
> > >         get_state_synchronize_rcu_full(&rgos);
> > >         synchronize_rcu();
> > >         WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));
> > >
> > > The RCU callbacks that awaken synchronize_rcu() instances are
> > > guaranteed not to be invoked before the root rcu_node structure's
> > > ->gp_seq field is updated to indicate the end of the grace period.
> > > However, these callbacks might start being invoked immediately
> > > thereafter, in particular, before rcu_state.gp_seq has been updated.
> > > Therefore, poll_state_synchronize_rcu_full() must refer to the
> > > root rcu_node structure's ->gp_seq field.  Because this field is
> > > updated under this structure's ->lock, any code following a call to
> > > poll_state_synchronize_rcu_full() will be fully ordered after the
> > > full grace-period computation, as is required by RCU's memory-orderin=
g
> > > semantics.
> > >
> > > By symmetry, the get_state_synchronize_rcu_full() function should als=
o
> > > use this same root rcu_node structure's ->gp_seq field.  But it turns=
 out
> > > that symmetry is profoundly (though extremely infrequently) destructi=
ve
> > > in this case.  To see this, consider the following sequence of events=
:
> > >
> > > 1.      CPU 0 starts a new grace period, and updates rcu_state.gp_seq
> > >         accordingly.
>
> I don't think so because idle CPUs are waited upon to report a QS, unlike
> offline CPUs that don't appear in ->qsmaskinitnext.
>
> If the CPU 1 is idle while the grace period kthread scans its
> ct_rcu_watching_cpu(), then the QS is reported on its behalf and when CPU=
 1
> goes out of idle it is guaranteed to see the new started GP on the root n=
ode.
>
> If the CPU 1 is not idle while the grace period kthread scans its
> ct_rcu_watching_cpu(), then CPU 1 must report a QS and that cancels the r=
ace.

Sorry, you are right. Idle CPUs are required to have QS reports done
for them or on their behalf. My bad.

thanks,

 - Joel
